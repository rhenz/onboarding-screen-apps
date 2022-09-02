//
//  QuoteCollectionViewCell.swift
//  onboarding-fashion-app
//
//  Created by John Salvador on 8/30/22.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var authorQuoteLabel: UILabel!
}

// MARK: - Setup UI
extension QuoteCollectionViewCell {
    func configure(with onboardingItem: OnboardingItem) {
        authorNameLabel.text = onboardingItem.authorName
        authorQuoteLabel.text = onboardingItem.authorQuote
    }
}
