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
    
    override var prefersStatusBarHidden: Bool { true }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }


}

// MARK: - Actions

extension OnboardingViewController {
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        
    }
}
