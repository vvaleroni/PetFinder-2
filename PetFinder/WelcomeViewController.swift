//
//  WelcomeViewController:.swift
//  Petfinder
//
//  Created by Va Leroni on 21.02.22.
//

import UIKit
import Firebase
import AVKit

class WelcomeViewController: UIViewController {
  var videoPlayer: AVPlayer?
  var videoPlayerLayer: AVPlayerLayer?
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var signupButton: UIButton!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
    setupVideo()
  }
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = false
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  func setupVideo() {
    guard let bundlePath = Bundle.main.path(forResource: "hatiko", ofType: "mp4") else { return }
    let url = URL(fileURLWithPath: bundlePath)
    let item = AVPlayerItem(url: url)
    videoPlayer = AVPlayer(playerItem: item)
    videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
    videoPlayerLayer?.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    view.layer.insertSublayer(videoPlayerLayer!, at: 0)
    videoPlayer?.playImmediately(atRate: 1)
    try! AVAudioSession.sharedInstance().setCategory(.playback)
  }
  func setupUI() {
    Utilities.styleFilledButton(signupButton)
    Utilities.styleHollowButton(loginButton)
  }
}
