//
//  PrefixHeader.swift
//  swift-APP框架搭建
//
//  Created by zl on 2019/5/30.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import UIKit

// 屏幕尺寸
let MyScreenW = UIScreen.main.bounds.width
let MyScreenH = UIScreen.main.bounds.height

// 颜色相关
func MyColor(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
}
func MyAlphaColor(_ r: Int, _ g: Int, _ b: Int, _ a: Float) -> UIColor {
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a / 1.0))
}
let MyWhiteColor = UIColor.white
