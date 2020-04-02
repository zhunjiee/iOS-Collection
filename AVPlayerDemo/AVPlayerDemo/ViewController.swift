//
//  ViewController.swift
//  AVPlayerDemo
//
//  Created by 侯歌 on 2020/3/31.
//  Copyright © 2020 HouGe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tools = BWPlayerToolsView(frame: CGRect(x: 0, y: 30, width: UIScreen.main.bounds.width, height: 30))
        view.addSubview(tools)
    }


}

