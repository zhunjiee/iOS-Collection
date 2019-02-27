//
//  StartViewController.swift
//  视频起始页
//
//  Created by 侯宝伟 on 16/9/9.
//  Copyright © 2016年 ZHUNJIEE. All rights reserved.
//

import UIKit
import MediaPlayer

class StartViewController: UIViewController, UIScrollViewDelegate {
    // 屏幕宽高
    let ScreenWidth = Singleton.sharedInstance.ScreenWidth
    let ScreenHeight = Singleton.sharedInstance.ScreenHeight
    // scrollView懒加载
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: -20, width: self.view.frame.size.width, height: self.view.frame.size.height + 20))
        /**
         枚举类型的多选
         */
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height)
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        
        return scrollView
    }()
    
    var lastIndex: CGFloat = 0
    
    var avPlayer1 = AVPlayer()
    var avPlayer2 = AVPlayer()
    var avPlayer3 = AVPlayer()
    var pagecontrol = UIPageControl()
    

    // 登录、注册按钮
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建添加滚动视图
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        
        // 将按钮移到最上面
        self.view.bringSubviewToFront(registerButton)
        self.view.bringSubviewToFront(loginButton)
        registerButton.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = registerButton.layer.cornerRadius
        
        do {
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
            } else {
                // Fallback on earlier versions
            }
        } catch {
            print("设置视频播放模式失败")
        }
        
        let movieUrl1 = NSURL.fileURL(withPath: Bundle.main.path(forResource: "1", ofType: "m4v")!)
        let movieUrl2 = NSURL.fileURL(withPath: Bundle.main.path(forResource: "2", ofType: "m4v")!)
        let movieUrl3 = NSURL.fileURL(withPath: Bundle.main.path(forResource: "3", ofType: "m4v")!)
        
        let asset1 = AVURLAsset(url: movieUrl1, options: nil)
        let asset2 = AVURLAsset(url: movieUrl2, options: nil)
        let asset3 = AVURLAsset(url: movieUrl3, options: nil)
        
        let playerItem1 = AVPlayerItem(asset: asset1)
        let playerItem2 = AVPlayerItem(asset: asset2)
        let playerItem3 = AVPlayerItem(asset: asset3)
        
        avPlayer1 = AVPlayer(playerItem: playerItem1)
        avPlayer2 = AVPlayer(playerItem: playerItem2)
        avPlayer3 = AVPlayer(playerItem: playerItem3)
        
        let avPlayerLayer1 = AVPlayerLayer(player: avPlayer1)
        let avPlayerLayer2 = AVPlayerLayer(player: avPlayer2)
        let avPlayerLayer3 = AVPlayerLayer(player: avPlayer3)
        
        avPlayerLayer1.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        avPlayerLayer2.frame = CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        avPlayerLayer3.frame = CGRect(x: self.view.frame.size.width * 2, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        // 视频充满
        avPlayerLayer1.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayerLayer2.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayerLayer3.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        scrollView.layer.addSublayer(avPlayerLayer1)
        scrollView.layer.addSublayer(avPlayerLayer2)
        scrollView.layer.addSublayer(avPlayerLayer3)
        
        avPlayer1.play()
        
        pagecontrol = UIPageControl(frame: CGRect(x: ScreenWidth / 2 - 100, y: ScreenHeight - 100, width: 200, height: 30))
        pagecontrol.numberOfPages = 3
        self.view.addSubview(pagecontrol)
        
        let logoImage = UIImageView(image: UIImage(named: "keep"))
        logoImage.frame = CGRect(x: (ScreenWidth - 180) / 2, y: (ScreenWidth - 100) / 2, width: 180, height: 50)
        self.view.addSubview(logoImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x / scrollView.frame.size.width
        
        if offset == lastIndex {
            return
        }
        
        if offset == 0 {
            avPlayer1.seek(to: CMTime.zero)
            avPlayer1.play()
            avPlayer2.seek(to: CMTime.zero)
            avPlayer2.pause()
            avPlayer3.seek(to: CMTime.zero)
            avPlayer3.pause()
            pagecontrol.currentPage = 0
        } else if offset == 1 {
            avPlayer1.seek(to: CMTime.zero)
            avPlayer1.pause()
            avPlayer2.seek(to: CMTime.zero)
            avPlayer2.play()
            avPlayer3.seek(to: CMTime.zero)
            avPlayer3.pause()
            pagecontrol.currentPage = 1
        } else if offset == 2 {
            avPlayer1.seek(to: CMTime.zero)
            avPlayer1.pause()
            avPlayer2.seek(to: CMTime.zero)
            avPlayer2.pause()
            avPlayer3.seek(to: CMTime.zero)
            avPlayer3.play()
            pagecontrol.currentPage = 2
        }
        
        lastIndex = offset
    }
}
