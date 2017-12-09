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
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        record.setObject("用餐", forKey: "sumary" as NSCopying)
        record.setObject("1", forKey: "imageTag" as NSCopying)
        record.setObject(Date.init(), forKey: "date" as NSCopying)
        
        self.dataAry.append(record)
        
        let userDefault = UserDefaults.init(suiteName: "group.com.keke.kekeroom")
        userDefault?.set(self.dataAry, forKey: "widgetData")
        userDefault?.synchronize()
        
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
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
