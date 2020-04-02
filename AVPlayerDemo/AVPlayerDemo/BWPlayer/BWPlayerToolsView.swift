//
//  BWPlayerToolsView.swift
//  AVPlayerDemo
//
//  Created by 侯歌 on 2020/3/31.
//  Copyright © 2020 HouGe. All rights reserved.
//

import UIKit

protocol BWPlayerToolsDelegate: NSObjectProtocol {
    func playStateDidChanged(state: Bool)
}

class BWPlayerToolsView: UIView {
    weak var delegate: BWPlayerToolsDelegate?
    // 播放按钮
    var playButton: UIButton
    // 进度条
    var progressBar: UISlider
    // 缓冲条
    var bufferView: UIProgressView
    // 时间进度
    var timeLabel: UILabel
    

    override init(frame: CGRect) {
        // 先初始化自己的属性
        playButton = UIButton(type: .custom)
        progressBar = UISlider()
        bufferView = UIProgressView()
        timeLabel = UILabel()
        // 在调用super.init
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        setupChildView()
    }
    
    required init?(coder: NSCoder) {
        playButton = UIButton(type: .custom)
        progressBar = UISlider()
        bufferView = UIProgressView()
        timeLabel = UILabel()
        super.init(coder: coder)
        backgroundColor = UIColor(white: 0, alpha: 0.5)
        setupChildView()
    }
    
    /// 创建子组件
    func setupChildView() {
        playButton = UIButton(type: .custom)
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.setImage(UIImage(named: "pause"), for: .selected)
        playButton.imageView?.contentMode = .center
        playButton.addTarget(self, action: #selector(playButtonDidClick(sender:)), for: .touchUpInside)
        addSubview(playButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playButton.frame = CGRect(x: 0, y: 0, width: frame.size.height, height: frame.size.height)
    }
    
    /// 点击了播放按钮 - 实现播放暂停的效果
    /// - Parameter sender: 播放按钮
    @objc func playButtonDidClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
