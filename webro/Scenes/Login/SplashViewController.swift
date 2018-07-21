//
//  SplashViewController.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: View Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        proceed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: Private Helpers

private extension SplashViewController {
    
    func proceed() {
        if UserDefaults.standard.accessToken == nil {
            let loginViewController: LoginViewController = UIViewController.instantiate()
            navigationController?.pushViewController(loginViewController, animated: false)
        } else {
            let homeViewController: HomeViewController = UIViewController.instantiate()
            navigationController?.pushViewController(homeViewController, animated: false)
        }
    }
}
