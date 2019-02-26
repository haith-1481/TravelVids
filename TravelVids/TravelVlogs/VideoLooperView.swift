//
//  File.swift
//  TravelVids
//
//  Created by trinh.hoang.hai on 2/26/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit
import AVFoundation

class VideoLooperView: UIView {
  let clips: [VideoClip]
  let videoPlayerView = VideoPlayerView()
  @objc private let player = AVQueuePlayer()
  private var token: NSKeyValueObservation?


  init(clips: [VideoClip]) {
    self.clips = clips
    super.init(frame: .zero)
    initializePlayer()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    private func initializePlayer() {
        videoPlayerView.player = player
        addAllVideosToPlayer()
        token = player.observe(\.currentItem) { [weak self] player, _ in
            if player.items().count == 1 {
                self?.addAllVideosToPlayer()
            }
        }
    }

    private func addAllVideosToPlayer() {
        for video in clips {
            let asset = AVURLAsset(url: video.url)
            let item = AVPlayerItem(asset: asset)

            player.insert(item, after: player.items().last)
            player.volume = 0.0
            player.play()
        }
    }

    func pause() {
        player.pause()
    }

    func play() {
        player.play()
    }
}
