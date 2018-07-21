//
//  UserDefaultsExtension.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import Foundation

private enum Keys: String {
    
    case accessToken
}

extension UserDefaults {
    
    // TODO: Keep in keychain
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.accessToken.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.accessToken.rawValue)
        }
    }
}
