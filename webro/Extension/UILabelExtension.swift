//
//  UILabelExtension.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

extension UILabel {
    
    func applyStyle(font: UIFont = UIFont.body2,
                    color: UIColor = UIColor.black,
                    kern: CGFloat = 0.3) {
        
        attributedText = NSAttributedString(text: text, font: font, color: color, kern: kern)
    }
}
