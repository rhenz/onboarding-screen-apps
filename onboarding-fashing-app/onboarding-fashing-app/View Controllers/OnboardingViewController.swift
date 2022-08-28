//
//  ViewController.swift
//  onboarding-fashing-app
//
//  Created by John Salvador on 8/28/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


// MARK: - Actions

extension OnboardingViewController {
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
}

