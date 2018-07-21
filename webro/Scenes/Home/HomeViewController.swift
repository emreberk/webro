//
//  HomeViewController.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: BaseViewController {
    
    private enum Constant {
        static let tableViewTopContraintMinimum: CGFloat = 50
        static let zoom: Float = 13
    }
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var tasks: [Task] = []
    private var currentTasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStylingToMapView()
        configureViews()
        getTasks()
    }
    
    func getTasks() {
        // Hero Mode On:
        showLoading(true)
        Service.main.request(Endpoint.tasks) { [weak self] (t: TasksResponse?, error) in
            
            guard let strongSelf = self, let tasks = t?.tasks else {
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                strongSelf.showLoading(false)
            }
            
            strongSelf.tasks = tasks
            strongSelf.currentTasks = tasks
            strongSelf.addMarkers()
            strongSelf.tableView.reloadData()
        }
        // Hero Mode Off:
    }
    
    func configureViews() {
        searchBar.delegate = self
        tableView.register(cell: TaskTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: Constant.tableViewTopContraintMinimum,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
    }
    
    func addMarkers() {
        for (index, task) in tasks.enumerated() {
            guard let latitude = task.fromLocation?.latitude,
                let longitude = task.fromLocation?.longitude else {
                    continue
            }
            
            if index == 0 {
                let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                                      longitude: longitude,
                                                      zoom: Constant.zoom)
                mapView.camera = camera
                mapView.isMyLocationEnabled = true
            }
            
            let marker = GMSMarker()
            marker.icon = task.type?.mapIcon
            marker.position = CLLocationCoordinate2DMake(latitude, longitude)
            marker.title = task.type?.description
            marker.map = mapView
        }
    }
    
    func applyStylingToMapView() {
        if let styleURL = Bundle.main.url(forResource: "mapstyle", withExtension: "json") {
            mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        }
    }
}

// MARK: UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            currentTasks = tasks
        } else {
            currentTasks = tasks.filter({
                    $0.address?.lowercased().contains(searchText.lowercased()) == true || $0.type?.description.lowercased().contains(searchText.lowercased()) == true
            })
        }
        tableView.reloadData()
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskTableViewCell = tableView.dequeue()
        cell.selectionStyle = .none
        let task = currentTasks[indexPath.row]
        cell.configure(task)
        cell.backgroundColor = task.status == .completed ? UIColor.lightMint : UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = currentTasks[indexPath.row]
        if task.status == .completed {
            return
        }
        let confirmationViewController: ConfirmationViewController = UIViewController.instantiate()
        confirmationViewController.delegate = self
        confirmationViewController.task = task
        present(confirmationViewController, animated: true, completion: nil)
    }
}

extension HomeViewController: ConfirmationViewControllerDelegate {
    
    func confirmationViewController(_ confirmationViewController: ConfirmationViewController,
                                    didAcceptTask task: Task?) {
     
        task?.status = .completed
        tableView.reloadData()
    }
    
    func confirmationViewController(_ confirmationViewController: ConfirmationViewController,
                                    didCancelTask task: Task?) {
        
        guard let task = task else {
            return
        }
        
        for (index,aTask) in currentTasks.enumerated() {
            if aTask.id == task.id {
                currentTasks.remove(at: index)
                tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
                break
            }
        }
    }
}
