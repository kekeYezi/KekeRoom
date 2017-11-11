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
    lazy var backButton = UIButton.init()
    lazy var titlePriceLabel = UILabel.init()
    lazy var priceLabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red:0.69, green:0.70, blue:0.33, alpha:1.00)
        self.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(self)
            make.width.height.equalTo(35)
        }
        backButton.setImage(UIImage.init(named: "type_big_1"), for: .normal)
//        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        self.addSubview(titlePriceLabel)
        titlePriceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(backButton.snp.right).offset(15);
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class KKCalculateIconView: UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let itemWidth : CGFloat = self.bounds.size.width / 6
        let itemHeight : CGFloat = 90
       
        for i in 0..<19 {
            let j = i % 6
            let k = i / 6
            print(j)
            print(k)
            
            let item = KKCalculateIconItemView.init(frame: CGRect.init(x: CGFloat(j) * itemWidth, y: CGFloat(k) * itemHeight, width: itemWidth, height: itemHeight))
            self.addSubview(item)
            item.iconItemImageView.image = UIImage.init(named: "type_big_\(i)")
            item.iconItemLabel.text = "一般"
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class KKCalculateIconItemView: UIView {
    lazy var iconItemImageView = UIImageView.init()
    lazy var iconItemLabel = UILabel.init()
    
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
        dateLabel.text = "2017\n今天"
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
                btn.setTitleColor(UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00), for: .normal)
                btn.addTarget(self, action: #selector(ok), for: .touchUpInside)
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
        
        let okbtn = UIButton.init(frame: CGRect.init(x: itemwidth  * CGFloat(3), y: itemheight * CGFloat(2) + 1, width: itemwidth, height: itemheight * CGFloat(2)))
        self.addSubview(okbtn)
        okbtn.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.00)
        okbtn.titleLabel?.font = UIFont.systemFont(ofSize: 33)
        okbtn.setTitle("ok", for: .normal)
        okbtn.setTitleColor(UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.00), for: .normal)
        okbtn.addTarget(self, action: #selector(ok), for: .touchUpInside)
    }
    
    @objc private func ok () {
        print("ok")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
