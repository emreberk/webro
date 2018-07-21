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
        static let tableViewTopContraintDefault: CGFloat = 300
        static let tableViewTopContraintMinimum: CGFloat = 100
        static let zoom: Float = 13
    }
    
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!
    
    private var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStylingToMapView()
        configureViews()
        getTasks()
    }
    
    func getTasks() {
        // Hero Mode On:
        Service.main.request(Endpoint.tasks) { [weak self] (t: TasksResponse?, error) in
            
            guard let strongSelf = self, let tasks = t?.tasks else {
                return
            }
            
            strongSelf.tasks = tasks
            strongSelf.addMarkers()
            strongSelf.tableView.reloadData()
        }
        // Hero Mode Off:
    }
    
    func configureViews() {
        tableView.register(cell: TaskTableViewCell.self)
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


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskTableViewCell = tableView.dequeue()
        let task = tasks[indexPath.row]
        cell.configure(task)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newConstant = Constant.tableViewTopContraintDefault - scrollView.contentOffset.y
        if newConstant > Constant.tableViewTopContraintMinimum {
            tableViewTopConstraint.constant = newConstant
        }
    }
}
