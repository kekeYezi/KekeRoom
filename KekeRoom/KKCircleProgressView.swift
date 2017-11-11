//
//  KKCircleProgressView.swift
//  KekeRoom
//
//  Created by keke on 2017/11/7.
//  Copyright © 2017年 keke. All rights reserved.
//

import Foundation
import UIKit

class KKCircleProgressView: UIView {
    lazy var tapseg : UITapGestureRecognizer = UITapGestureRecognizer.init()
    lazy var ccImageView = UIImageView.init()
    var tapBlock : (()->())?

    
    var value: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var maximumValue: CGFloat = 0 {
        didSet { self.setNeedsDisplay() }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //线宽度
        let lineWidth: CGFloat = 1.5
        //半径
        let radius = rect.width / 2.0 - lineWidth
        //中心点x
        let centerX = rect.midX
        //中心点y
        let centerY = rect.midY
        //弧度起点
        let startAngle = CGFloat(-90 * Double.pi / 180)
        //弧度终点
        let endAngle = CGFloat(((self.value / self.maximumValue) * 360.0 - 90.0) ) * CGFloat(Double.pi) / 180.0
        
        //创建一个画布
        let context = UIGraphicsGetCurrentContext()
        
        //画笔颜色
        context!.setStrokeColor(UIColor(red:0.49, green:0.64, blue:0.63, alpha:1.00).cgColor)
        
        //画笔宽度
        context!.setLineWidth(lineWidth)
        
        //（1）画布 （2）中心点x（3）中心点y（4）圆弧起点（5）圆弧结束点（6） 0顺时针 1逆时针
        context?.addArc(center: CGPoint(x:centerX,y:centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        //绘制路径
        context!.strokePath()
        
        //画笔颜色
        context!.setStrokeColor(UIColor(red:0.63, green:0.47, blue:0.61, alpha:1.00).cgColor)
        
        //（1）画布 （2）中心点x（3）中心点y（4）圆弧起点（5）圆弧结束点（6） 0顺时针 1逆时针
        context?.addArc(center: CGPoint(x:centerX,y:centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        //绘制路径
        context!.strokePath()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.addSubview(ccImageView)
        ccImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        ccImageView.image = UIImage.init(named: "circle_btn")
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = UIBezierPath.init(roundedRect: frame, cornerRadius: frame.size.width / 2).cgPath
        self.layer.mask = maskLayer

        self.addGestureRecognizer(tapseg)
        tapseg.addTarget(self, action: #selector(tap))
        
    }
    
    @objc private func tap () {
        print("1")
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .autoreverse, animations: {
            self.ccImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat((Double.pi/4)*(1)))
        }, completion: {(need) in
            self.ccImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat((Double.pi/4)*(0)))
        })

        if let block = tapBlock {
            block()
        }
        
    }
    
}
