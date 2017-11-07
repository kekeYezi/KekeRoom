//
//  HomeViewController.swift
//  KekeRoom
//
//  Created by keke on 2017/11/7.
//  Copyright © 2017年 keke. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    lazy var headImageView = UIImageView.init()
    
    lazy var labelsBgView = UIView.init()
    lazy var currentIncomeLabel = UILabel.init()
    lazy var currentExpendLabel = UILabel.init()
    lazy var currentIncomeAccountLabel = UILabel.init()
    lazy var currentExpendAccountLabel = UILabel.init()
    
    lazy var circelView  = KKCircleProgressView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addHeadImageView()
        self.addAccoutLabels()
        self.addCircelView()
        
    }
    
    // MARK: - UI
    func addHeadImageView() {
        headImageView.image = UIImage.init(named: "background")
        self.view.addSubview(headImageView)
        headImageView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(0)
            make.height.equalTo(155)
        }
    }
    
    func addAccoutLabels() {
        
        self.view.addSubview(labelsBgView)
        labelsBgView.snp.makeConstraints { (make) in
            make.top.equalTo(headImageView.snp.bottom)
            make.width.equalTo(self.view)
            make.height.equalTo(90)
        }
        
        let fontSize :CGFloat = 15
        
        labelsBgView.addSubview(currentIncomeLabel)
        labelsBgView.addSubview(currentExpendLabel)
        labelsBgView.addSubview(currentIncomeAccountLabel)
        labelsBgView.addSubview(currentExpendAccountLabel)
        
        currentIncomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(labelsBgView.snp.top).offset(15)
            make.left.equalTo(15)
        }
        currentIncomeLabel.font = UIFont.systemFont(ofSize: 15)
        currentIncomeLabel.text = "当月收入"
        currentIncomeLabel.textColor = UIColor.gray
        
        currentExpendLabel.snp.makeConstraints { (make) in
            make.top.equalTo(labelsBgView.snp.top).offset(15)
            make.right.equalTo(-15)
        }
        currentExpendLabel.font = UIFont.systemFont(ofSize: 15)
        currentExpendLabel.text = "当月支出"
        currentExpendLabel.textColor = UIColor.gray
        
        currentIncomeAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currentIncomeLabel.snp.bottom).offset(fontSize)
            make.left.equalTo(currentIncomeLabel.snp.left)
        }
        currentIncomeAccountLabel.font = UIFont.systemFont(ofSize: fontSize)
        currentIncomeAccountLabel.text = "0.00"
        currentIncomeAccountLabel.textColor = UIColor.gray
        
        currentExpendAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(currentExpendLabel.snp.bottom).offset(fontSize)
            make.left.equalTo(currentExpendLabel.snp.left)
        }
        currentExpendAccountLabel.font = UIFont.systemFont(ofSize: fontSize)
        currentExpendAccountLabel.text = "805.20"
        currentExpendAccountLabel.textColor = UIColor.gray
    }
    
    func addCircelView () {
        circelView = KKCircleProgressView.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 120))
        self.view.addSubview(circelView)
        circelView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(headImageView.snp.bottom)
            make.width.height.equalTo(120)
        }
        
        circelView.value = 30
        circelView.maximumValue = 80;
    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
