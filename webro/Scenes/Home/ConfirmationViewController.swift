//
//  ConfirmationViewController.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

protocol ConfirmationViewControllerDelegate: class {
    
    func confirmationViewController(_ confirmationViewController: ConfirmationViewController,
                                    didAcceptTask task: Task?)
    
    func confirmationViewController(_ confirmationViewController: ConfirmationViewController,
                                    didCancelTask task: Task?)
}

class ConfirmationViewController: BaseViewController {
    
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var popupView: UIView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var taskNameLabel: UILabel!
    @IBOutlet private weak var topSeparator: UIView!
    @IBOutlet private weak var centerSeparator: UIView!
    @IBOutlet private weak var bottomSeparator: UIView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var confirmButton: UIButton!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var distanceAmountLabel: UILabel!
    @IBOutlet private weak var distanceCurrecyLabel: UILabel!
    @IBOutlet private weak var gainLabel: UILabel!
    @IBOutlet private weak var gainValueLabel: UILabel!
    
    var task: Task?
    weak var delegate: ConfirmationViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .overCurrentContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        applyLocalizations()
        applyStyling()
    }
    
    func configureViews() {
        view.backgroundColor = .clear
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(backgroundViewTapped)))
        
        thumbnailImageView.image = #imageLiteral(resourceName: "photo")
    }
    
    func applyLocalizations() {
        distanceLabel.text = "MESAFE"
        gainLabel.text = "KAZANÇ"
        gainValueLabel.attributedText = gainValueText()
        distanceAmountLabel.text = "\(arc4random_uniform(50)+5)"
        distanceCurrecyLabel.text = "BINA"
        taskNameLabel.text = task?.type?.description.uppercased()
    }
    
    func applyStyling() {
        popupView.clipsToBounds = true
        popupView.layer.cornerRadius = UIConstant.cornerRadius
        
        nameLabel.applyStyle(font: .heading3)
        taskNameLabel.applyStyle(font: .body10, color: UIColor.black50)
        
        [topSeparator, centerSeparator, bottomSeparator].forEach { (view) in
            view?.backgroundColor = UIColor.whiteTwo
        }
        
        cancelButton.setAttributedTitle(NSAttributedString(text: "REDDET",
                                                           font: .mainButton,
                                                           color: .white),
                                        for: .normal)
        cancelButton.layer.cornerRadius = UIConstant.cornerRadius
        cancelButton.backgroundColor = UIColor.coral
        
        confirmButton.setAttributedTitle(NSAttributedString(text: "KABUL ET",
                                                            font: .mainButton,
                                                            color: .white),
                                        for: .normal)
        confirmButton.layer.cornerRadius = UIConstant.cornerRadius
        confirmButton.backgroundColor = UIColor.algaeGreen
        
        distanceLabel.applyStyle(font: .body10, color: UIColor.black50)
        gainLabel.applyStyle(font: .body10, color: UIColor.black50)
        
        distanceAmountLabel.applyStyle(font: .number2)
        distanceCurrecyLabel.applyStyle(font: .distance, color: UIColor.black.withAlphaComponent(0.7))
    }
    
    private func gainValueText() -> NSMutableAttributedString {
        guard let priceForTask = task?.type?.price else {
            return NSMutableAttributedString()
        }
        let attributedString = NSMutableAttributedString(string: "\(priceForTask).00 TL", attributes: [
            .font: UIFont.systemFont(ofSize: 22.0, weight: .medium),
            .foregroundColor: UIColor.black,
            .kern: 0.0
            ])
        attributedString.addAttributes([
            .font: UIFont.number6,
            .foregroundColor: UIColor.greyishBrown
            ], range: NSRange(location: 3, length: 1))
        attributedString.addAttributes([
            .font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
            .foregroundColor: UIColor.greyishBrown
            ], range: NSRange(location: 4, length: 2))
        attributedString.addAttributes([
            .font: UIFont(name: "Catamaran-Regular", size: 11.0)!,
            .foregroundColor: UIColor.greyishBrown
            ], range: NSRange(location: 7, length: 2))
        return attributedString
    }
    
    @objc
    func backgroundViewTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Actions

private extension ConfirmationViewController {
    
    @IBAction func cancelButtonTapped() {
        delegate?.confirmationViewController(self, didCancelTask: task)
        backgroundViewTapped()
    }
    
    @IBAction func acceptButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.confirmationViewController(self, didAcceptTask: self.task)
        }
    }
}
