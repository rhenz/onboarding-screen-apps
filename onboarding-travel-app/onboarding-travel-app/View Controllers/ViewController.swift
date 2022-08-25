//
//  ViewController.swift
//  onboarding-travel-app
//
//  Created by John Salvador on 8/24/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var darkView: UIView!
    @IBOutlet var backgroundImageView: UIImageView!
    
    private let onboardingItems: [OnboardingItem] = OnboardingItem.createItems()
    private let currentPage = 0
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        setupScreen(for: currentPage)
        setupGestures()
    }
}

// MARK: - Setup UI

extension ViewController {
    private func setupPageControl() {
        pageControl.numberOfPages = onboardingItems.count
    }
    
    private func setupScreen(for index: Int) {
        titleLabel.text = onboardingItems[index].title
        detailLabel.text = onboardingItems[index].detail
        pageControl.currentPage = index
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Actions

extension ViewController {
    @objc private func handleTapAnimation() {
        print("Tapped")
    }
}
