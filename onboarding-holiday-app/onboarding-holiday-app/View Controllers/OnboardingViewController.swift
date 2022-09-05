//
//  ViewController.swift
//  onboarding-holiday-app
//
//  Created by John Salvador on 9/5/22.
//

import UIKit
import AVKit

class OnboardingViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var darkView: UIView!
    @IBOutlet var getStartedButton: UIButton!
    
    // MARK: - Properties
    
    private var playerLooperService: AVPlayerLooperService = {
        guard let filePath = Bundle.main.path(forResource: "bg_holiday", ofType: "mp4") else {
            fatalError("Failed to find video path.")
        }
        
        return AVPlayerLooperService(with: URL(fileURLWithPath: filePath))
    }()
    
    override var prefersStatusBarHidden: Bool { true }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        playBackgroundVideoInLoop()
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

// MARK: - Setup UI

extension OnboardingViewController {
    private func setupViews() {
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.4)
    }
}

// MARK: - AVPlayer

extension OnboardingViewController {
    private func playBackgroundVideoInLoop() {
        playerLooperService.playLoopedVideo(in: view)
    }
}

// MARK: - Actions

extension OnboardingViewController {
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        
    }
}
