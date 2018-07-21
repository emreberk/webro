//
//  BaseViewController.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private enum Constant {
        static let loadingViewTag = 42981
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoading(_ show: Bool) {
        // Hero Mode On:
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let existingViews = window.subviews.filter({ $0.tag == Constant.loadingViewTag })
        if existingViews.count > 0 {
            existingViews.forEach({ $0.removeFromSuperview() })
        } else {
            var images = [UIImage]()
            for i in 0...73 {
                let name = "spideranima00" + String(format: "%02d", i)
                images.append(UIImage(named:name)!)
            }
            
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.black50
            imageView.isUserInteractionEnabled = true
            imageView.tag = Constant.loadingViewTag
            imageView.frame = CGRect(origin: .zero, size: UIScreen.main.bounds.size)
            imageView.animationImages = images
            
            window.endEditing(true)
            window.addSubview(imageView)
            imageView.startAnimating()
        }
        // Hero Mode Off:
    }
    
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Keyboard
    
    func addKeyboardObservers(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
    }
    
    func removeKeyboardObservers(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(keyboardHeight: CGFloat, duration: Double){
        // Implement in subclass
    }
    
    func keyboardWillHide(keyboardHeight: CGFloat, duration: Double){
        // Implement in subclass
    }
    
    // MARK: - Private Functions
    
    @objc private func keyboardWillHide(_ not:Foundation.Notification){
        let info: NSDictionary = (not as NSNotification).userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        
        let duration = info.value(forKey: UIKeyboardAnimationDurationUserInfoKey) as! Double
        
        keyboardWillHide(keyboardHeight: keyboardSize.height, duration: duration)
    }
    
    @objc private func keyboardWillShow(_ not:Foundation.Notification){
        let info: NSDictionary = (not as NSNotification).userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.cgRectValue.size
        
        let duration = info.value(forKey: UIKeyboardAnimationDurationUserInfoKey) as! Double
        
        keyboardWillShow(keyboardHeight: keyboardSize.height, duration: duration)
    }
    
}
