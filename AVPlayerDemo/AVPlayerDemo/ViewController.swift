//
//  ViewController.swift
//  AVPlayerDemo
//
//  Created by 侯歌 on 2020/3/31.
//  Copyright © 2020 HouGe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    lazy var player: AVAudioPlayer = {
        let path = Bundle.main.path(forResource: "test", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path ?? "")
        let player = try! AVAudioPlayer(contentsOf: url as URL)
        player.numberOfLoops = 0
        player.volume = 1.0
        player.prepareToPlay()
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tools = BWPlayerToolsView(frame: CGRect(x: 0, y: 30, width: UIScreen.main.bounds.width, height: 30))
        view.addSubview(tools)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.play()
    }
}

