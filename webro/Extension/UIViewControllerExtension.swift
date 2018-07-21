//
//  UIViewControllerExtension.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // Hero Mode On:
    static func instantiate<T: UIViewController>(fromStoryboard name: String = "Main") -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
    // Hero Mode Off:
}
