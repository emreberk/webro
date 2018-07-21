//
//  NSAttributedStringExtension.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init(text: String?,
                     font: UIFont = UIFont.b2,
                     color: UIColor = UIColor.black,
                     kern: CGFloat = 0.3) {
        
        let attributes: [NSAttributedStringKey: Any] = [
            .font: font,
            .foregroundColor: color,
            .kern: kern
        ]
        
        self.init(string: text ?? "", attributes: attributes)
    }
}
