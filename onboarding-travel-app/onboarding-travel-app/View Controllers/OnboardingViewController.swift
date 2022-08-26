//
//  ViewController.swift
//  onboarding-travel-app
//
//  Created by John Salvador on 8/24/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
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
        setupViews()
    }
}

// MARK: - Setup UI

extension OnboardingViewController {
    private func setupViews() {
        darkView.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    private func updateBackgroundImage(index: Int) {
        UIView.transition(with: backgroundImageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve) {
            self.backgroundImageView.image = self.onboardingItems[index].bgImage
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = onboardingItems.count
    }
    
    private func setupScreen(for index: Int) {
        titleLabel.text = onboardingItems[index].title
        detailLabel.text = onboardingItems[index].detail
        pageControl.currentPage = index
        
        titleLabel.alpha = 1.0
        detailLabel.alpha = 1.0
        titleLabel.transform = .identity
        detailLabel.transform = .identity
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Actions

extension OnboardingViewController {
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
            
            // Update background image
            if self.currentPage < self.onboardingItems.count - 1 {
                self.updateBackgroundImage(index: self.currentPage + 1)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.detailLabel.alpha = 0
                self.detailLabel.transform = CGAffineTransform(translationX: -30, y: -55)
            } completion: { _ in
                // Show next onboarding screen
                self.currentPage += 1
                
                
                if self.isOverLastItem() {
                    // Show main screen
                    self.showMainScreen()
                } else {
                    self.setupScreen(for: self.currentPage)
                }
                
            }
        }
    }
    
    private func isOverLastItem() -> Bool {
        return currentPage >= self.onboardingItems.count
    }
    
    private func showMainScreen() {
        
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        
        if let window = view.window {
            window.rootViewController = mainVC
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
