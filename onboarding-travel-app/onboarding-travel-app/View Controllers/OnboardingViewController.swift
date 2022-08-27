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
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
        return tapGesture
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
        setupScreen(for: currentPage)
        enableTapGesture()
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
                          duration: 0.8,
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
        
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .beginFromCurrentState) {
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.4) {
                self.titleLabel.alpha = 1.0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4) {
                self.detailLabel.alpha = 1.0
            }
        } completion: { _ in
            self.enableTapGesture()
        }
    }
    
    private func enableTapGesture() {
        tapGesture.isEnabled = true
    }
    
    private func disableTapGesture() {
        tapGesture.isEnabled = false
    }
}

// MARK: - Actions

extension OnboardingViewController {
    
    private var isOverLastItem: Bool {
        currentPage >= self.onboardingItems.count
    }
    
    private func animateOnboardingScreen() {
        let moveToLeftValue: CGFloat = 30
        
        disableTapGesture()
        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                options: .beginFromCurrentState) {
            
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.2) {
                self.titleLabel.alpha = 0.8
                self.titleLabel.transform = CGAffineTransform(translationX: -moveToLeftValue, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2,
                               relativeDuration: 0.2) {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4,
                               relativeDuration: 0.2) {
                self.detailLabel.alpha = 0.8
                self.detailLabel.transform = CGAffineTransform(translationX: -moveToLeftValue, y: 0)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.6,
                               relativeDuration: 0.2) {
                self.detailLabel.alpha = 0
                self.detailLabel.transform = CGAffineTransform(translationX: 0, y: -550)
            }
            
            self.updateBackgroundImage(index: self.currentPage + 1)
            
        } completion: { _ in
            self.currentPage += 1
            
            if self.isOverLastItem {
                self.showMainScreen()
            } else {
                self.setupScreen(for: self.currentPage)
            }
        }
    }
    
    @objc private func handleTapAnimation() {
        animateOnboardingScreen()
    }
}
