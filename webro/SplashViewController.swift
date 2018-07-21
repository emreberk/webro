//
//  SplashViewController.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        proceed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func proceed() {
        if UserDefaults.standard.accessToken == nil {
            let loginViewController: LoginViewController = UIViewController.instantiate()
            navigationController?.pushViewController(loginViewController, animated: true)
        } else {
            // TODO: Proceed to main
        }
    }
}
