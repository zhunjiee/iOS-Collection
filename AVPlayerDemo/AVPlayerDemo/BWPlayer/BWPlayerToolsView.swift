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
    var playButton: UIButton?
    // 进度条
    var progressBar: UISlider?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createChildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createChildView()
    }
    
    func createChildView() {
        playButton = UIButton(type: .custom)
        progressBar = UISlider()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
