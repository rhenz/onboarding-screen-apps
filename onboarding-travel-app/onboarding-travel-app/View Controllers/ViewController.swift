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
    private var currentPage = 0
    
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
        // First animation - title
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550 )
            }
        }

        // Second animation - detail label
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
            self.detailLabel.alpha = 0.8
            self.detailLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.detailLabel.alpha = 0
                self.detailLabel.transform = CGAffineTransform(translationX: -30, y: -55)
            } completion: { _ in
                print("done")
                // Show next onboarding screen
                self.currentPage += 1
                self.titleLabel.alpha = 1.0
                self.detailLabel.alpha = 1.0
                self.titleLabel.transform = .identity
                self.detailLabel.transform = .identity
                self.setupScreen(for: self.currentPage)
            }
        }

    }
}
