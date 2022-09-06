//
//  OnboardingCell.swift
//  onboarding-restaurant-app
//
//  Created by John Salvador on 9/6/22.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var animationView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var actionButton: UIButton!
}

// MARK: - Internal Helper Methods

extension OnboardingCell {
    
    func configure(with item: OnboardingItem) {
        titleLabel.text = item.title
        actionButton.backgroundColor = item.buttonColor
        actionButton.titleLabel?.text = item.buttonTitle
    }
}

// MARK: - Actions

extension OnboardingCell {
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        
    }
}
