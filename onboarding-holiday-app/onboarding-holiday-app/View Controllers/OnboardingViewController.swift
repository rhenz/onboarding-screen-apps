//
//  ViewController.swift
//  onboarding-holiday-app
//
//  Created by John Salvador on 9/5/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var darkView: UIView!
    @IBOutlet var getStartedButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

// MARK: - Actions

extension OnboardingViewController {
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        
    }
}
