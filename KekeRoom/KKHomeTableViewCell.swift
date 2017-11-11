//
//  HomeTableViewCell.swift
//  KekeRoom
//
//  Created by keke on 2017/11/11.
//  Copyright © 2017年 keke. All rights reserved.
//

import Foundation
import UIKit

class KKHomeTableViewCell : UITableViewCell {
    lazy var iconImageView : UIImageView = UIImageView.init()
    lazy var contentLabel : UILabel = UILabel.init()
    lazy var priceLabel : UILabel = UILabel.init()
    lazy var lineLabel : UILabel = UILabel.init()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(lineLabel)
        lineLabel.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.00)
        lineLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(0.5)
            make.top.bottom.equalTo(0)
        }
        
        self.contentView.addSubview(iconImageView)
        let name = arc4random()%30
        iconImageView.image = UIImage.init(named: "type_big_\(name)")
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.height.width.equalTo(35);
        }
        
        self.contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.centerY.equalTo(iconImageView)
        }
        priceLabel.textColor = UIColor(red:0.50, green:0.53, blue:0.56, alpha:1.00)
        
        self.contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel.snp.right).offset(6)
            make.centerY.equalTo(iconImageView)
        }
        priceLabel.font = UIFont.systemFont(ofSize: 15)
        priceLabel.textColor = UIColor(red:0.49, green:0.53, blue:0.56, alpha:1.00)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeTableViewSectionView: UIView {
    lazy var lineLabel : UILabel = UILabel.init()
    lazy var iconView : UIView = UIView.init()
    lazy var titleDateLabel : UILabel = UILabel.init()
    lazy var titlePriceLabel : UILabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(lineLabel)
        lineLabel.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.00)
        lineLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.equalTo(0.5)
            make.top.bottom.equalTo(0)
        }
        
        self.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(5)
            make.center.equalTo(self)
        }
        iconView.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.00)
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = 2.5

        self.addSubview(titleDateLabel)
        titleDateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.right.equalTo(iconView.snp.left).offset(-10)
        }

        self.addSubview(titlePriceLabel)
        titlePriceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconView)
            make.left.equalTo(iconView.snp.right).offset(10)
        }
        
        titlePriceLabel.font = UIFont.systemFont(ofSize: 12)
        titleDateLabel.font = UIFont.systemFont(ofSize: 12)
        titlePriceLabel.textColor = UIColor(red:0.66, green:0.66, blue:0.66, alpha:1.00)
        titleDateLabel.textColor  = UIColor(red:0.66, green:0.66, blue:0.66, alpha:1.00)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
