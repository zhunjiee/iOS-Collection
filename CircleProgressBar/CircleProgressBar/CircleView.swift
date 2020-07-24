//
//  CircleView.swift
//  CircleProgressBar
//
//  Created by Houge on 2020/5/4.
//  Copyright © 2020 QTTX. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    lazy var circleLayer: CAShapeLayer = {
        let circle = CAShapeLayer()
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.red.cgColor
        circle.strokeEnd = 0.0
        circle.lineWidth = 5.0
        return circle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.clear
        // 添加需要动画的图层
        layer.addSublayer(circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 考虑到视图的布局，如通过 auto layout,
        // 需动画图层的布局，放在这里
        // arcCenter 圆心
        // radius 半径
        // startAngle 开始角度
        // endAngle 结束角度
        // clockwise 顺/逆时针
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width/2.0, y: frame.size.height/2.0), radius: (frame.size.width-10)/2.0, startAngle: 0.0, endAngle: CGFloat(Double.pi*2.0), clockwise: true)
        circleLayer.path = circlePath.cgPath
    }
    
    /// 动画方法
    func animateCircle(duration t: TimeInterval) {
        // 画圆形，就是靠 `strokeEnd`
        let animation = CABasicAnimation(keyPath: "stokeEnd")
        
        animation.duration = t
        animation.fromValue = 0.0
        animation.toValue = 1.0
        
        // 指定动画的时间函数，保持匀速
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        // 视图具体的位置，与动画结束的效果一致
        circleLayer.strokeEnd = 1.0
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
