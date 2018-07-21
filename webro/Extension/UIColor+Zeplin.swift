//
//  UIColor+Zeplin.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

extension UIColor {
    
    @nonobjc class var black: UIColor {
        return UIColor(white: 19.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var orangeRed: UIColor {
        return UIColor(red: 1.0, green: 39.0 / 255.0, blue: 39.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var mudBrown: UIColor {
        return UIColor(red: 46.0 / 255.0, green: 10.0 / 255.0, blue: 10.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black0: UIColor {
        return UIColor(white: 19.0 / 255.0, alpha: 0.0)
    }
    
    @nonobjc class var black50: UIColor {
        return UIColor(white: 19.0 / 255.0, alpha: 0.5)
    }
    
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 224.0 / 255.0, green: 223.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var warmGrey: UIColor {
        return UIColor(white: 138.0 / 255.0, alpha: 1.0)
    }
}
