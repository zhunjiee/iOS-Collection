//
//  BigImageViewer.swift
//  BigImageViewer
//
//  Created by zl on 2019/7/30.
//  Copyright © 2019 ZHUNJIEE. All rights reserved.
//

import UIKit

class BigImageViewer: UIImageView {
    // MARK: -  常量
    let BWScreenW = UIScreen.main.bounds.width
    let BWScreenH = UIScreen.main.bounds.height
    let keyWindow = UIApplication.shared.keyWindow

    // MARK: -  懒加载
    lazy var backView: UIView = {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: BWScreenW, height: BWScreenH))
        backView.backgroundColor = UIColor.black
        return backView
    }()
    lazy var actionImageView: UIImageView = {
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    
    // MARK: -  初始化
    override init(image: UIImage?) {
        super.init(image: image)
        addTapGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGestureRecognizer()
    }
    
    /// 添加点击手势方法
    func addTapGestureRecognizer() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(picTapAction(tap:))))
    }
}


// MARK: -  点击方法
extension BigImageViewer {
    
    /// 点击图片,显示大图
    @objc func picTapAction(tap: UITapGestureRecognizer) {
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapAction)))
        // 计算imageView相对于屏幕的frame
        let frame = convert(bounds, to: keyWindow)
        actionImageView.frame = frame
        guard let win = UIApplication.shared.delegate?.window as? UIView else { return }
        win.addSubview(backView)
        win.addSubview(actionImageView)
        
        UIView.animate(withDuration: 0.3) {
            let fixelW = CGFloat(self.actionImageView.image?.cgImage?.width ?? 0)
            let fixelH = CGFloat(self.actionImageView.image?.cgImage?.height ?? 0)
            self.actionImageView.frame = CGRect(x: 0, y: 0, width: self.BWScreenW, height: fixelH * self.BWScreenW / fixelW)
            self.actionImageView.center = self.backView.center
        }
    }
    
    /// 点击大图,隐藏并返回
    @objc func backTapAction() {
        let frame = convert(bounds, to: keyWindow)
        UIView.animate(withDuration: 0.3
            , animations: {
                self.actionImageView.frame = frame
                self.actionImageView.alpha = 0.3
                self.backView.alpha = 0.3
        }) { (finished) in
            self.backView.removeFromSuperview()
            self.actionImageView.removeFromSuperview()
            self.actionImageView.alpha = 1.0
            self.backView.alpha = 1.0
        }
    }
}
