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

// MARK: - Navigation

extension OnboardingViewController {
    private func showMainScreen() {
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        
        if let window = view.window {
            window.rootViewController = mainVC
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

// MARK: - Setup UI

extension OnboardingViewController {
    private func setupViews() {
        pageControl.allowsContinuousInteraction = false
        pageControl.isUserInteractionEnabled = false
    }
    
    private func updateBackgroundImage(index: Int) {
        guard index < onboardingItems.count else { return }
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
        
        // Return to original place
        self.titleLabel.transform = .identity
        self.detailLabel.transform = .identity
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve) {
            self.titleLabel.alpha = 1.0
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .transitionCrossDissolve) {
            self.detailLabel.alpha = 1.0
        }
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Actions

extension OnboardingViewController {
    
    private var isOverLastItem: Bool {
        currentPage >= self.onboardingItems.count
    }
    
    @objc private func handleTapAnimation() {
        
        let animationDuration = 0.5
        let damping = 0.5
        let initialSpringVelocity = 0.5
        let moveToLeftValue: CGFloat = 30
        
        // First animation - title
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity:
                        initialSpringVelocity,
                       options: .curveEaseInOut) {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -moveToLeftValue, y: 0)
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initialSpringVelocity,
                           options: .curveEaseInOut) {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550 )
            }
        }
        
        // Second animation - detail label
        UIView.animate(withDuration: animationDuration,
                       delay: 0.5,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: initialSpringVelocity,
                       options: .curveEaseInOut) {
            self.detailLabel.alpha = 0.8
            self.detailLabel.transform = CGAffineTransform(translationX: -moveToLeftValue, y: 0)
        } completion: { _ in
            // Change background image
            self.updateBackgroundImage(index: self.currentPage + 1)
            
            // Remove detail label out of the screen
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initialSpringVelocity,
                           options: .curveEaseInOut) {
                self.detailLabel.alpha = 0
                self.detailLabel.transform = CGAffineTransform(translationX: -30, y: -30)
            } completion: { _ in
                // Show next onboarding screen
                self.currentPage += 1
                
                if self.isOverLastItem {
                    // Show main screen
                    self.showMainScreen()
                } else {
                    self.setupScreen(for: self.currentPage)
                }
            }
        }
    }
}
