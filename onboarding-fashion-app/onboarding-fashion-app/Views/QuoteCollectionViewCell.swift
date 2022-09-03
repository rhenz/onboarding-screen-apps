//
//  QuoteCollectionViewCell.swift
//  onboarding-fashion-app
//
//  Created by John Salvador on 8/30/22.
//

import UIKit

protocol QuoteCollectionViewCellDelegate: AnyObject {
    func quoteCollectionViewCell(_ cell: QuoteCollectionViewCell, didTapExploreButton button: UIButton)
}

class QuoteCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: QuoteCollectionViewCellDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var authorQuoteLabel: UILabel!
    @IBOutlet var exploreButton: UIButton!
}

// MARK: - Actions

extension QuoteCollectionViewCell {
    @IBAction func exploreButtonTapped(_ sender: UIButton) {
        delegate?.quoteCollectionViewCell(self, didTapExploreButton: sender)
    }
}

// MARK: - Public Methods

extension QuoteCollectionViewCell {
    func showExploreButton(shouldShow: Bool) {
        exploreButton.isHidden = !shouldShow
    }
    
    func configure(with onboardingItem: OnboardingItem) {
        authorNameLabel.text = onboardingItem.authorName
        authorQuoteLabel.text = onboardingItem.authorQuote
    }
}
