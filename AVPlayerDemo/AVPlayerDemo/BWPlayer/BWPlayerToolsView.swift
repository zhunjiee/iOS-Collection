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
    lazy var playButton: UIButton = {
        let btn = UIButton(type: .custom)
        return btn
    }()
    // 进度条
    lazy var progressBar: UISlider = {
        let progressBar = UISlider()
        return progressBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
