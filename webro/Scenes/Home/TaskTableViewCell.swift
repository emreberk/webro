//
//  TaskTableViewCell.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet private(set) weak var iconImageView: UIImageView!
    @IBOutlet private(set) weak var typeNameLabel: UILabel!
    @IBOutlet private(set) weak var locationLabel: UILabel!
    @IBOutlet private(set) weak var minuteLabel: UILabel!
    @IBOutlet private(set) weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ task: Task) {
        typeNameLabel.text = task.type?.description
        iconImageView.image = task.type?.icon
        locationLabel.text = task.address
        minuteLabel.text = "\(arc4random_uniform(5)+1)"
        rightLabel.text = "dk."
        applyStyling()
    }
    
    private func applyStyling() {
        typeNameLabel.applyStyle(font: .body4)
        locationLabel.applyStyle(font: .body9, color: UIColor.warmGrey)
        minuteLabel.applyStyle(font: .number1)
        rightLabel.applyStyle(font: .body12)
    }
    
}
