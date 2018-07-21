//
//  FormTextField.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import SkyFloatingLabelTextField

class FormTextField: SkyFloatingLabelTextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyle()
    }
    
    private func applyStyle() {
        lineColor = .paleGrey
        selectedLineColor = .paleGrey
        placeholderFont = UIFont.body7
        placeholderColor = UIColor.black.withAlphaComponent(0.5)
        selectedTitleColor = UIColor.black.withAlphaComponent(0.5)
        textColor = .black
        font = UIFont.body2
        titleFormatter = { (title: String) in return title }
    }
}
