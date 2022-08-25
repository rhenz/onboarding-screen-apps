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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

