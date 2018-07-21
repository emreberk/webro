//
//  BaseViewController.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
