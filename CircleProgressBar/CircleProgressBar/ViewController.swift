//
//  ViewController.swift
//  CircleProgressBar
//
//  Created by Houge on 2020/5/4.
//  Copyright © 2020 QTTX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var circleV: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func animateStoryboard(_ sender: UIButton) {
        circleV.animateCircle(duration: 12.0)
    }
}

