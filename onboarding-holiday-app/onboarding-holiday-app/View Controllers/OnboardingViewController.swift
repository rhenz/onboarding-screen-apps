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
    
    override var prefersStatusBarHidden: Bool { true }
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupPlayerIfNeeded()
        restartVideo()
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
    private func buildPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "bg_holiday", ofType: ".mp4") else {
            return nil
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: filePath))
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        layer.frame = view.bounds
        return layer
    }
    
    private func playVideo() {
        player?.play()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func pauseVideo() {
        player?.pause()
    }
    
    private func setupPlayerIfNeeded() {
        player = buildPlayer()
        playerLayer = buildPlayerLayer()
        
        guard let playerLayer = self.playerLayer,
              viewDoesNotContainPlayerLayer
        else {
            return
        }
        
        view.layer.insertSublayer(playerLayer, at: 0)
    }
    
    private var viewDoesNotContainPlayerLayer: Bool {
        if let playerLayer = self.playerLayer, let sublayers = view.layer.sublayers {
            return !sublayers.contains(playerLayer)
        } else {
            return false
        }
    }
}

// MARK: - Actions

extension OnboardingViewController {
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        
    }
}
