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
    
    // MARK: - Properties
    
    private var playerLooperService: AVPlayerLooperService?
    
    override var prefersStatusBarHidden: Bool { true }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        setupPlayerLooperService()
        playBackgroundVideoInLoop()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
        stopLooperService()
    }
}

// MARK: - Actions

extension OnboardingViewController {
    @objc private func appMovedToBackground() {
        playerLooperService?.pause()
    }
    
    @objc private func appEnterForeground() {
        playerLooperService?.play()
    }
}

// MARK: - Setup UI

extension OnboardingViewController {
    private func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViews() {
        darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.4)
    }
}

// MARK: - AVPlayer

extension OnboardingViewController {
    private func setupPlayerLooperService() {
        guard let filePath = Bundle.main.path(forResource: "bg_holiday-hd", ofType: "mp4") else {
            fatalError("Failed to find video path.")
        }
        
        playerLooperService = AVPlayerLooperService(with: URL(fileURLWithPath: filePath))
    }
    
    private func stopLooperService() {
        playerLooperService?.stopLooping()
        playerLooperService = nil
    }
    
    private func playBackgroundVideoInLoop() {
        playerLooperService?.playLoopedVideo(in: view)
    }
}
