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

class ChargeRecord: Object {
    @objc dynamic var date = Date.init()
    @objc dynamic var sumary = "一般"
    @objc dynamic var price:Double = 0
    @objc dynamic var imageTag = "1"
}
