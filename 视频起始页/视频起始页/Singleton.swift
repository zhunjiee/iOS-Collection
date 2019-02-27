//
//  Singleton.swift
//  视频起始页
//
//  Created by 侯宝伟 on 16/9/9.
//  Copyright © 2016年 ZHUNJIEE. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    static let sharedInstance = Singleton()

    let ScreenWidth = UIScreen.main.bounds.width
    let ScreenHeight = UIScreen.main.bounds.height
    
    func RGBColor(R: CGFloat, G: CGFloat, B: CGFloat) -> UIColor {
        return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1)
    }
    
    func RGBAColor(R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat) -> UIColor {
        return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: A)
    }
}
