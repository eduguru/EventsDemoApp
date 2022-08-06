//
//  VideoPlaybackViewController.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 05/08/2022.
//

import AVFoundation
import AVKit
import Kingfisher
import UIKit

class VideoPlaybackViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var btn_play: UIButton! {
        didSet {
            btn_play.setTitle("", for: .normal)
        }
    }

    var viewModel: VideoPlaybackViewModel!
    var playerAV: AVPlayer!
    var videoUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = viewModel.selected.title
        videoUrl = viewModel.selected.videoUrl

        btn_play.addTarget(self, action: #selector(actionPlay), for: .touchUpInside)
        guard let videoUrl = URL(string: videoUrl ?? "") else {
            return
        }

        self.imageView.kf.setImage(with: AVAssetImageDataProvider(assetURL: videoUrl, seconds: 1))
    }

    @objc func actionPlay() {
        guard let url = videoUrl else {
            return
        }
        self.playvideo(videourl: url)
    }

    private func playvideo(videourl: String) {
        guard let url = URL(string: videourl) else { return }

        let player = AVPlayer(url: url)
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.allowsPictureInPicturePlayback = true
        playerController.player?.play()
        self.present(playerController, animated: true, completion: nil)
    }
}
