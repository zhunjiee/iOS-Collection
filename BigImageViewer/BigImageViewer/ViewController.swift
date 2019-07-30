//
//  ViewController.swift
//  BigImageViewer
//
//  Created by zl on 2019/7/30.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stybdImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pic = BigImageViewer(image: UIImage(named: "pic"))
        pic.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(pic)
    }


}

