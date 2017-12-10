//
//  TodayViewController.swift
//  KekeRoomWidget
//
//  Created by keke on 2017/12/9.
//  Copyright © 2017年 keke. All rights reserved.
//

import UIKit
import NotificationCenter
import RealmSwift
import Realm

class TodayViewController: UIViewController, NCWidgetProviding {
    var dataAry = Array<Any>()
        
    @IBOutlet weak var moneyField: UITextField!
    
    @IBOutlet weak var successLabel: UILabel!
    
    @IBOutlet weak var sunmaryLabel: UILabel!
    
    @IBOutlet weak var iconBtn: UIButton!
    
    let sumarysArrays = ["用餐","交通","一般"]
    let iconArrays = ["2","4","1"]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = UserDefaults.init(suiteName: "group.com.keke.kekeroom")
        let widgetInfo:[NSMutableDictionary] = userDefault?.object(forKey: "widgetData")! as! [NSMutableDictionary]
        
        for obj in widgetInfo {
           self.dataAry.append(obj)
        }
        
        self.iconBtn.setImage(UIImage.init(named: "type_big_\(self.iconArrays[index])"), for: .normal)
        self.sunmaryLabel.text = self.sumarysArrays[index]
        
        print(NSHomeDirectory())

    }
    
    @IBAction func addRecordAction(_ sender: Any) {
        
        if (self.moneyField.text?.characters.count == 0) {
            self.shakePriceLabel()
            print("请输入金额")
            return
        }

        let record = NSMutableDictionary.init()
        record.setObject(self.moneyField.text!, forKey: "price" as NSCopying)
        record.setObject(self.sumarysArrays[index], forKey: "sumary" as NSCopying)
        record.setObject(self.iconArrays[index], forKey: "imageTag" as NSCopying)
        record.setObject(Date.init(), forKey: "date" as NSCopying)
        
        self.dataAry.append(record)
        
        let userDefault = UserDefaults.init(suiteName: "group.com.keke.kekeroom")
        userDefault?.set(self.dataAry, forKey: "widgetData")
        userDefault?.synchronize()
        
        self.moneyField.text = ""
        self.successLabel.text = "添加成功"
        self.perform(#selector(clearInfo), with: self, afterDelay: 1.5)
        
    }
    
    @IBAction func changeTypeAction(_ sender: Any) {
        self.index = self.index + 1
        if (self.index % 3) == 0 {
            self.index = 0
        }
        self.iconBtn.setImage(UIImage.init(named: "type_big_\(self.iconArrays[index])"), for: .normal)
        self.sunmaryLabel.text = self.sumarysArrays[index]
    }
    
    @objc func clearInfo() {
        self.successLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.moneyField.layer.add(kfa, forKey: "shake")
        
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
}
