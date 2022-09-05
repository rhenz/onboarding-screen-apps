//
//  AVPlayerLooperService.swift
//  onboarding-holiday-app
//
//  Created by John Salvador on 9/5/22.
//

import AVKit

class AVPlayerLooperService {
    
    // MARK: - Properties
    
    let fileUrl: URL
    
    private var videoPlayerLayer: AVPlayerLayer?
    private var videoPlayer: AVQueuePlayer?
    private let playerLooper: AVPlayerLooper
    
    // MARK: - Init
    
    init(with fileURL: URL) {
        self.fileUrl = fileURL
        
        // Setup
        let asset = AVAsset(url: fileURL)
        let playerItem = AVPlayerItem(asset: asset)
        
        // Assign an array of 1 item to AVQueuePlayer
        videoPlayer = AVQueuePlayer(items: [playerItem])
        
        // Loop the video
        playerLooper = AVPlayerLooper(player: videoPlayer!, templateItem: playerItem)
        
        // Create video player layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
    }
    
    // MARK: - Public API
    
    func playLoopedVideo(in view: UIView) {
        guard let videoPlayerLayer = videoPlayerLayer,
              viewDoesNotContainPlayerLayer(in: view)
        else {
            fatalError("Should not insert another player layer in the view")
        }
        
        // Adjust size and frame
        videoPlayerLayer.frame = view.bounds
        videoPlayerLayer.videoGravity = .resizeAspectFill
        
        view.layer.insertSublayer(videoPlayerLayer, at: 0)
        
        // Play video
        videoPlayer?.play()
    }
    
    func play() {
        videoPlayer?.play()
    }
    
    func pause() {
        videoPlayer?.pause()
    }
    
    func stopLooping() {
        videoPlayer?.pause()
        videoPlayer = nil
        
        videoPlayerLayer?.removeFromSuperlayer()
        videoPlayerLayer = nil
    }
}

// MARK: - Helper Methods

extension AVPlayerLooperService {
    private func viewDoesNotContainPlayerLayer(in view: UIView) -> Bool {
        if let sublayers = view.layer.sublayers, let videoPlayerLayer = videoPlayerLayer {
            return !sublayers.contains(videoPlayerLayer)
        } else {
            return false
        }
    }
}
