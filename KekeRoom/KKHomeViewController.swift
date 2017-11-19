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
import Realm
import RealmSwift
import LeanCloud

class KKHomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    lazy var headImageView = UIImageView.init()
    
    lazy var labelsBgView = UIView.init()
    lazy var currentIncomeLabel = UILabel.init()
    lazy var currentExpendLabel = UILabel.init()
    lazy var currentIncomeAccountLabel = UILabel.init()
    lazy var currentExpendAccountLabel = UILabel.init()
    var recordDataAry:[[ChargeRecord]] = []
    var totalPrice:Double = 0
    
    lazy var mainTableView = UITableView.init(frame: CGRect.init(), style: .plain)
    
    lazy var circelView  = KKCircleProgressView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addHeadImageView()
        self.addAccoutLabels()
        self.addCircelView()
        self.addTableView()
        
        let lineLabel = UILabel.init()
        self.view.addSubview(lineLabel)
        lineLabel.backgroundColor = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.00)
        lineLabel.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.top.equalTo(circelView.snp.bottom)
            make.bottom.equalTo(mainTableView.snp.top)
            make.centerX.equalTo(circelView.snp.centerX)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.readNetData()
        print("viewWillAppear")
    }
    
    // MARK: - 读取数据相关逻辑
    // 从LC 服务端读取数据
    func readNetData () {
        totalPrice = 0;
        
        let query = LCQuery(className: "ChargeRecord")
        query.find { result in
            switch result {
            case .success(let objects):
                var pup:[ChargeRecord] = []
                for lcm:LCObject in objects {
                    let a = ChargeRecord().getLCModel(object: lcm)
                    pup.append(a)
                }
                
                let pups = pup.sorted(by: {(model1: ChargeRecord, model2: ChargeRecord) -> Bool in
                    let timeInterval1:TimeInterval = model1.date.timeIntervalSince1970
                    let timeStamp1 = Int(timeInterval1)
                    
                    let timeInterval2:TimeInterval = model2.date.timeIntervalSince1970
                    let timeStamp2 = Int(timeInterval2)

                    return timeStamp1 > timeStamp2
                })

                self.recordDataAry.removeAll()
                self.getTotalAry(puppies: pups)
                
                self.reloadUI()
                
            break // 查询成功
            case .failure(let error):
                print(error)
                self.readLocalRealm()
                self.reloadUI()
            }
        }
    }
    
    // 本地数据库读取
    func readLocalRealm () {
        let realm = try! Realm()
        let puppies = realm.objects(ChargeRecord.self).sorted(by: {(model1: ChargeRecord, model2: ChargeRecord) -> Bool in
            
            let timeInterval1:TimeInterval = model1.date.timeIntervalSince1970
            let timeStamp1 = Int(timeInterval1)
            
            let timeInterval2:TimeInterval = model2.date.timeIntervalSince1970
            let timeStamp2 = Int(timeInterval2)
            
            return timeStamp1 > timeStamp2
        })
        self.recordDataAry.removeAll()
        self.getTotalAry(puppies: puppies)
        
        self.reloadUI()
        self.mainTableView.reloadData()
    }
    
    func getTotalAry(puppies:[ChargeRecord]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        
        var lastString = ""
        for model:ChargeRecord in puppies {
            let string = formatter.string(from: model.date as Date)
            if string == lastString {
                var ary:[ChargeRecord] = recordDataAry[recordDataAry.count - 1]
                ary.append(model)
                totalPrice = totalPrice + model.price
                let countt:Int = recordDataAry.count - 1
                recordDataAry[countt] = ary
                //                print(ary)
            } else {
                lastString = string
                var ary:[ChargeRecord] = []
                ary.append(model)
                totalPrice = totalPrice + model.price
                recordDataAry.append(ary)
            }
        }
    }
    
    func reloadUI () {
        currentExpendAccountLabel.text = "\(totalPrice)"
        self.mainTableView.reloadData()
    }
    
    // MARK: - UI
    func addHeadImageView() {
        headImageView.image = UIImage.init(named: "background")
        self.view.addSubview(headImageView)
        headImageView.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(0)
            make.height.equalTo(155)
        }
        
        let labelName = UILabel.init()
        self.view.addSubview(labelName)
        
        labelName.text = "可可小屋"
        labelName.textColor = UIColor.white
        labelName.font = UIFont.systemFont(ofSize: 25)
        labelName.snp.makeConstraints { (make) in
            make.left.top.equalTo(20)
        };
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
            make.right.equalTo(currentExpendLabel.snp.right)
        }
        currentExpendAccountLabel.font = UIFont.systemFont(ofSize: fontSize)
        currentExpendAccountLabel.text = "\(totalPrice)"
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
        circelView.tapBlock = { () in
            self.present(KKCalculateViewController(), animated: true, completion: {
            })
        }
    
    }
    
    func addTableView () {
        self.view.addSubview(mainTableView)
        mainTableView.separatorStyle = .none
        mainTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.snp.makeConstraints { (make) in
            make.top.equalTo(labelsBgView.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        
    }
    
    // MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordDataAry[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recordDataAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "KKHomeTableViewCell"
        
        var cell : KKHomeTableViewCell! = tableView.dequeueReusableCell(withIdentifier: (indentifier)) as? KKHomeTableViewCell
        
        if cell == nil {
            cell = KKHomeTableViewCell.init(style: .default, reuseIdentifier: indentifier)
        }
    
        let a = recordDataAry[indexPath.section]
        
        let record:ChargeRecord = a[indexPath.row]
        cell.contentLabel.text = record.sumary
        cell.priceLabel.text = "\(record.price)"
        cell.iconButton.setImage(UIImage.init(named: "type_big_\(record.imageTag)"), for: .normal)
        cell.cellModel = record
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HomeTableViewSectionView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.height, height: 20))
        var prices:Double = 0
        var dateStirng:String = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "dd日"
        
        for ary:[ChargeRecord] in recordDataAry {
            for model in ary {
                prices = prices + model.price
                
            }
        }
    
        let dateModelInfo:ChargeRecord = recordDataAry[section][0]
        dateStirng = formatter.string(from: dateModelInfo.date)
        view.titlePriceLabel.text = "\(prices)"
        view.titleDateLabel.text = dateStirng
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sc = -scrollView.contentOffset.y
        if sc < 0 {
            
            return
        }
        if sc > 100 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.present(KKCalculateViewController(), animated: true, completion: {
                })
            }
            return
        }
        
        circelView.ccImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat((Double.pi/4) * Double(sc/50)))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
