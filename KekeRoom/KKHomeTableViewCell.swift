//
//  HomeTableViewCell.swift
//  KekeRoom
//
//  Created by keke on 2017/11/11.
//  Copyright © 2017年 keke. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class KKHomeTableViewCell : UITableViewCell {
    var disposeBag = DisposeBag()
    var shouldShows:Bool = true
    var cellModel:ChargeRecord = ChargeRecord()
    
    lazy var iconButton : UIButton = UIButton.init()
    lazy var iconDelButton : UIButton = UIButton.init()
    lazy var iconEditButton : UIButton = UIButton.init()
    
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
        
        self.contentView.addSubview(iconDelButton)
        iconDelButton.alpha = 0
        iconDelButton.rx.tap
        .subscribe(onNext: { [weak self] x in
            let alter = UIAlertController.init(title: "提示", message: "您是否确定要删除所选账目", preferredStyle: .alert)
            alter.addAction(UIAlertAction(title: "取消", style: .cancel) { _ in
                
            })
            alter.addAction(UIAlertAction(title: "确定", style: .default) { _ in
                
            })
            
            self?.getCurrentViewController()?.present(alter, animated: true, completion: nil)
        })
        .disposed(by: disposeBag)
        iconDelButton.setImage(UIImage.init(named: "item_delete"), for: .normal)
        iconDelButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.height.width.equalTo(35);
        }
        
        self.contentView.addSubview(iconEditButton)
        iconEditButton.alpha = 0
        iconEditButton.rx.tap.subscribe(onNext: { [weak self] x in
            let vc = KKCalculateViewController()
            vc.initModel = (self?.cellModel)!
            self?.getCurrentViewController()!.present(vc, animated: true, completion: {
            })
        })
            .disposed(by: disposeBag)
        iconEditButton.setImage(UIImage.init(named: "item_edit"), for: .normal)
        iconEditButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.height.width.equalTo(35);
        }
        
        self.contentView.addSubview(iconButton)
        iconButton.rx.tap
            .subscribe(onNext: { [weak self] x in
                print("1")
                self?.showDelAndEdit(shouldShow: self!.shouldShows)
            })
            .disposed(by: disposeBag)
        
        iconButton.setImage(UIImage.init(named: "type_big_1"), for: .normal)
        iconButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.height.width.equalTo(35);
        }
        
        self.contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconButton.snp.right).offset(10)
            make.centerY.equalTo(iconButton)
        }
        priceLabel.textColor = UIColor(red:0.75, green:0.76, blue:0.77, alpha:1.00)
        
        self.contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentLabel.snp.right).offset(6)
            make.centerY.equalTo(iconButton)
        }
        priceLabel.font = UIFont.systemFont(ofSize: 15)
        priceLabel.textColor = UIColor(red:0.49, green:0.53, blue:0.56, alpha:1.00)
    }
    
    private func showDelAndEdit(shouldShow:Bool) {
        shouldShows = !shouldShow
        UIView.animate(withDuration: 0.2) {
            self.priceLabel.alpha = shouldShow ? 0 : 1
            self.contentLabel.alpha = shouldShow ? 0 : 1
            self.iconDelButton.alpha = shouldShow ? 1 : 0
            self.iconEditButton.alpha = shouldShow ? 1 : 0
            
            self.iconDelButton.center = CGPoint.init(x: self.iconDelButton.center.x + (shouldShow ? -100 : 100), y: self.iconDelButton.center.y)
            self.iconEditButton.center = CGPoint.init(x: self.iconEditButton.center.x + (shouldShow ? 100 : -100), y: self.iconEditButton.center.y)
        }
    }
    
    // 找到当前显示的window
    func getCurrentWindow() -> UIWindow? {
        
        // 找到当前显示的UIWindow
        var window: UIWindow? = UIApplication.shared.keyWindow
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindowLevelNormal {
            
            for tempWindow in UIApplication.shared.windows {
                
                if tempWindow.windowLevel == UIWindowLevelNormal {
                    
                    window = tempWindow
                    break
                }
            }
        }
        
        return window
    }
    
    // MARK: 获取当前屏幕显示的viewController
    func getCurrentViewController() -> UIViewController? {
        
        // 1.声明UIViewController类型的指针
        var viewController: UIViewController?
        
        // 2.找到当前显示的UIWindow
        let window: UIWindow? = self.getCurrentWindow()
        
        // 3.获得当前显示的UIWindow展示在最上面的view
        let frontView = window?.subviews.first
        
        // 4.找到这个view的nextResponder
        let nextResponder = frontView?.next
        
        if nextResponder?.isKind(of: UIViewController.classForCoder()) == true {
            
            viewController = nextResponder as? UIViewController
        }
        else {
            
            viewController = window?.rootViewController
        }
        
        return viewController
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
