//
//  KKCalculateViewController.swift
//  KekeRoom
//
//  Created by keke on 2017/11/11.
//  Copyright © 2017年 keke. All rights reserved.
//

import Foundation
import UIKit

class KKCalculateViewController : UIViewController {
    lazy var titleView = KKCalculateNavView.init()
    lazy var priceView = KKShowPriceView.init()
    lazy var iconsView = KKCalculateIconView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 360))
    
    lazy var noteView = KKCalculateNoteView.init()
    lazy var caculateView = KKCalculateView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 280))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.showTitleView()
        self.showPriceView()
        self.showIconsView()
        self.showCalculateView()
        self.showNoteView()
        
    }
    
    func showTitleView () {
        self.view.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.height.equalTo(50)
        }
        titleView.backBlock = ({ () in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func showPriceView () {
        self.view.addSubview(priceView)
        priceView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(titleView.snp.bottom)
            make.height.equalTo(60)
        }
    }
    
    func showIconsView () {
        self.view.addSubview(iconsView)
        iconsView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(priceView.snp.bottom)
            make.height.equalTo(400)
        }
        
        iconsView.iconBlock = { (item) in
            UIView.animate(withDuration: 0.5, animations: {
                self.priceView.backgroundColor = item.iconItemColor
                self.priceView.titlePriceLabel.text = item.iconItemLabel.text
                self.priceView.priceIconImageView.image = item.iconItemImageView.image
            })
            
        }
    }
    
    func showNoteView () {
        self.view.addSubview(noteView)
        noteView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(caculateView.snp.top)
            make.height.equalTo(44)
        }
    }
    
    func showCalculateView () {
        self.view.addSubview(caculateView)
        caculateView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(280)
        }
        caculateView.calculateBlock = { result in
            self.priceView.priceLabel.text = "\(result)"
        }
        caculateView.gerResultBlock = { result in
            if Double(result)! <= 0 {
                // doudong
                print("dd")
                self.priceView.shakePriceLabel()
            } else {
               self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
}


class KKCalculateNavView: UIView {
    lazy var backButton = UIButton.init()
    lazy var titleLabel = UILabel.init()
    var backBlock : (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.width.height.equalTo(20)
        }
        backButton.setImage(UIImage.init(named: "back_close"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        titleLabel.textColor = UIColor(red:0.92, green:0.67, blue:0.23, alpha:1.00)
        titleLabel.font = UIFont.systemFont(ofSize: 19)
        titleLabel.text = "支出"
    }
    
    @objc private func back () {
        print("1")
        if let block = backBlock {
            block()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class KKShowPriceView: UIView {
    lazy var priceIconImageView = UIImageView.init()
    lazy var titlePriceLabel = UILabel.init()
    lazy var priceLabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.69, green:0.70, blue:0.33, alpha:1.00)
        self.addSubview(priceIconImageView)
        priceIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(35)
        }
        priceIconImageView.image = UIImage.init(named: "type_big_1")
        
        self.addSubview(titlePriceLabel)
        titlePriceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(priceIconImageView.snp.right).offset(15);
        }
        titlePriceLabel.font = UIFont.systemFont(ofSize: 15)
        titlePriceLabel.textColor = UIColor.white
        titlePriceLabel.text = "一般"
        
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-10);
        }
        priceLabel.font = UIFont.systemFont(ofSize: 29)
        priceLabel.textColor = UIColor.white
        priceLabel.text = "¥ 0.00"
    }
    
    func shakePriceLabel () {
        // shake animation
        let kfa = CAKeyframeAnimation()
        kfa.keyPath = "transform.translation.x"
        let s = 4
        kfa.values = [-s,0,s,0,-s,0,s,0]
        kfa.duration = 0.4
        kfa.repeatCount = 1
        kfa.isRemovedOnCompletion = true
        priceLabel.layer.add(kfa, forKey: "shake")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class KKCalculateIconView: UIView {
    var iconBlock : ((_:KKCalculateIconItemView) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let itemWidth : CGFloat = self.bounds.size.width / 6
        let itemHeight : CGFloat = 90
       
        for i in 0..<10 {
            let j = i % 6
            let k = i / 6
            print(j)
            print(k)
            
            let titleAry = ["一般","用餐","零食","交通","信用卡","女士","娱乐","住房","饮料","备用"]
            let colorsAry = [UIColor(red:0.69, green:0.70, blue:0.33, alpha:1.00),
                             UIColor(red:0.54, green:0.67, blue:0.66, alpha:1.00),
                             UIColor(red:0.60, green:0.47, blue:0.41, alpha:1.00),
                             UIColor(red:0.44, green:0.51, blue:0.70, alpha:1.00),
                             UIColor(red:0.59, green:0.73, blue:0.86, alpha:1.00),
                             UIColor(red:0.87, green:0.56, blue:0.74, alpha:1.00),
                             UIColor(red:0.88, green:0.58, blue:0.32, alpha:1.00),
                             UIColor(red:0.80, green:0.73, blue:0.42, alpha:1.00),
                             UIColor(red:0.54, green:0.42, blue:0.69, alpha:1.00),
                             UIColor(red:0.94, green:0.52, blue:0.20, alpha:1.00)]
            
            let item = KKCalculateIconItemView.init(frame: CGRect.init(x: CGFloat(j) * itemWidth, y: CGFloat(k) * itemHeight, width: itemWidth, height: itemHeight))
            self.addSubview(item)
            item.iconItemImageView.image = UIImage.init(named: "type_big_\(i+1)")
            item.iconItemLabel.text = titleAry[i]
            item.iconItemColor = colorsAry[i]
            item.tapBlock = {
                if self.iconBlock != nil {
                    self.iconBlock!(item)
                }
            }
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class KKCalculateIconItemView: UIView {
    lazy var iconItemImageView = UIImageView.init()
    lazy var iconItemLabel = UILabel.init()
    lazy var iconItemColor = UIColor.white
    lazy var tapges = UITapGestureRecognizer.init(target: self, action: #selector(tap))
    var tapBlock : (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(iconItemImageView)
        iconItemImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.height.equalTo(48)
            make.centerY.equalTo(self.snp.centerY).offset(-15)
        }
        
        self.addSubview(iconItemLabel)
        iconItemLabel.textAlignment = .center
        iconItemLabel.textColor = UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.00)
        iconItemLabel.font = UIFont.systemFont(ofSize: 14)
        iconItemLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.left.right.equalTo(0)
            make.top.equalTo(iconItemImageView.snp.bottom).offset(5)
        }
        
       self.addGestureRecognizer(tapges)
        
    }
    
    @objc private func tap () {
        if tapBlock != nil {
            tapBlock!()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class KKCalculateNoteView: UIView {
    lazy var dateLabel = UILabel.init()
    lazy var writeButton = UIButton.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(35)
            make.top.bottom.equalTo(0)
        }
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let dateString = formatter.string(from: currentDate as Date)
        dateLabel.text = dateString
        
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.textColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1.00)
        
        self.addSubview(writeButton)
        writeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.centerY.equalTo(self)
            make.width.height.equalTo(30)
        }
        writeButton.setImage(UIImage.init(named: "addItem_remark"), for: .normal)
        writeButton.addTarget(self, action: #selector(write), for: .touchUpInside)
        
        
    }
    
    @objc private func write () {
        print("1")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class KKCalculateView: UIView {
    var calculateBlock : ((_:String) -> ())?
    var gerResultBlock : ((_:String) -> ())?
    let moneyStr = "¥ "
    var resultStringX :String = "0"
    var resultStringY :String = "0"
    var controltX = true
    var ifAdd = true
    var complete = false
    var lastResultStringX :String = "0"
    var lastResultStringY :String = "0"
    
    var okbtn : UIButton = UIButton.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
        
        let itemwidth : CGFloat = CGFloat(self.bounds.size.width / 4)
        let itemheight : CGFloat = CGFloat(self.bounds.size.height / 4)
        
        let strings = ["1","2","3","+","4","5","6","-","7","8","9","","清零","0",".",""]
        
        for i in 0..<4 {
            for j in 0..<4 {
                let btn = UIButton.init(frame: CGRect.init(x: itemwidth  * CGFloat(j), y: itemheight * CGFloat(i), width: itemwidth, height: itemheight))
                
                self.addSubview(btn)
                btn.setTitle(strings[4*i + j], for: .normal)
                btn.setTitleColor(UIColor(red:0.55, green:0.55, blue:0.55, alpha:1.00), for: .normal)
                btn.addTarget(self, action: #selector(calculate(_:)), for: .touchUpInside)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 29)
                
            }
        }
        
        for i in 0..<4 {
            print(i)
            let whiteVLine = UILabel.init()
            self.addSubview(whiteVLine)
            whiteVLine.backgroundColor = UIColor.white
            whiteVLine.snp.makeConstraints({ (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(1)
                make.top.equalTo(Int(itemheight) * i)
            })
        }
        
        for i in 0..<4 {
            print(i)
            let whiteHLine = UILabel.init()
            self.addSubview(whiteHLine)
            whiteHLine.backgroundColor = UIColor.white
            whiteHLine.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(0)
                make.width.equalTo(1)
                make.left.equalTo(Int((self.bounds.size.width / 4)) * i)
            })
        }
        
        okbtn.frame = CGRect.init(x: itemwidth  * CGFloat(3), y: itemheight * CGFloat(2) + 1, width: itemwidth, height: itemheight * CGFloat(2))
        self.addSubview(okbtn)
        okbtn.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
        okbtn.titleLabel?.font = UIFont.systemFont(ofSize: 33)
        okbtn.setTitle("ok", for: .normal)
        okbtn.setTitleColor(UIColor(red:0.55, green:0.55, blue:0.55, alpha:1.00), for: .normal)
        okbtn.addTarget(self, action:#selector(calculate(_:)), for: .touchUpInside)
    }
    
    @objc private func calculate (_ btn : UIButton) {
        
        let text = btn.titleLabel?.text!
        guard text != "ok" else {
            if gerResultBlock != nil {
                gerResultBlock!(self.getResultString().replacingOccurrences(of: moneyStr, with: ""))
            }
            return
        }
        
        guard text != "." else {
            if complete {
                self.reset()
            }
            controltX = false
            return
        }
        
        guard text != "+" && text != "-"else {
            complete = false
            lastResultStringX = resultStringX
            lastResultStringY = resultStringY
            resultStringX = "0"
            resultStringY = "0"
            controltX = true
            if text == "+" {
                ifAdd = true
            } else {
                ifAdd = false
            }
            okbtn.setTitle("=", for: .normal)
            return
        }
        
        if text == "1" || text == "2" ||
           text == "3" || text == "4" ||
           text == "5" || text == "6" ||
           text == "7" || text == "8" ||
           text == "9" || text == "0" {
            
            if complete {
                self.reset()
            }
            
            if controltX == true {
                if resultStringX == "0" {
                    resultStringX = text!
                } else {
                    resultStringX = resultStringX + text!
                }
            } else {
                if resultStringY == "0" {
                    resultStringY = text!
                } else {
                    if resultStringY.characters.count == 2 {
                        // 不能再添加   抖动动画提示
                        print("抖动")
                    } else {
                        resultStringY = resultStringY + text!
                    }
                }
            }
            
        } else if (text == "清零") {
            self.reset()
        } else if (text == "=") {
            var result : Double = 0
            var resultX : String = "0"
            var resultY : String = "0"
            let lastcontet : Double = Double(lastResultStringX + "." + lastResultStringY)!
            let currentcontent : Double = Double(resultStringX + "." + resultStringY)!
            if ifAdd {
                result = lastcontet + currentcontent
            } else {
                result = lastcontet - currentcontent
            }
            let tresult =  NSString.init(format: "%.2f", result)
            let ary = String(tresult).components(separatedBy: ".")
            resultX = ary[0]
            resultY = ary[1]
            
            resultStringX = resultX
            resultStringY = resultY
            
            okbtn.setTitle("ok", for: .normal)
            complete = true
        }
        
        if calculateBlock != nil {
            calculateBlock!(self.getResultString())
        }
    }
    
    func getResultString () -> String {
        let sry = resultStringY.characters.count == 1 ? resultStringY + "0" : resultStringY
        return (moneyStr + resultStringX + "." + sry)
    }
    
    func reset () {
        lastResultStringX = "0"
        lastResultStringX = "0"
        resultStringX = "0"
        resultStringY = "0"
        controltX = true
        ifAdd = true
        complete = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
