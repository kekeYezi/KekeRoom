//
//  ChargeRecord.swift
//  KekeRoom
//
//  Created by keke on 2017/11/15.
//  Copyright © 2017年 keke. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import LeanCloud

class ChargeRecord: Object {
    @objc dynamic var date = Date.init()
    @objc dynamic var sumary = "一般"
    @objc dynamic var price:Double = 0
    @objc dynamic var imageTag = "1"
    
    public func save(a: @escaping (_ success:Bool)->()) {
        let post = LCObject(className: "ChargeRecord")
        post.set("date", value: dateWithDate(date: self.date))
        post.set("sumary", value: self.sumary)
        post.set("price", value: self.price)
        post.set("imageTag", value: self.imageTag)
        post.save { result in
            switch result {
            case .success:
                a(true)
                break
            case .failure(let error):
                a(false)
                print(error)
            }
        }
    }
    
    public func getLCModel(object:LCObject) -> ChargeRecord {
        let model = ChargeRecord()

        let string:LCString = object.get("sumary") as! LCString
        model.sumary = string.value
        
        let imageTag:LCString = object.get("imageTag") as! LCString
        model.imageTag = imageTag.value
        
        let date:LCDate = object.get("date") as! LCDate
        model.date = date.value
        
        let price:LCNumber = object.get("price") as! LCNumber
        model.price = price.value
        
        return model
    }
    
    public func getDicModel(object:NSMutableDictionary) -> ChargeRecord {
        let model = ChargeRecord()
        
        let string:String = object.object(forKey: "sumary")! as! String
        model.sumary = string
        
        let imageTag:String = object.object(forKey: "imageTag")! as! String
        model.imageTag = imageTag
        
        let date:Date = object.object(forKey: "date")! as! Date
        model.date = date
        
        let price:String = object.object(forKey: "price")! as! String
        model.price = Double(price)!
        
        return model
    }
        
    func dateWithDate(date: Date) -> LCDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = LCDate(dateFormatter.date(from: dateFormatter.string(from: date))!)
        return date
    }
}
