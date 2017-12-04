//
//  Notification.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import UIKit

class Notification {
    var date: Date?
    var status: String
    var title: String
    
    init(date: Double, status: String, title: String) {
        self.date = Date(timeIntervalSince1970: date)
        self.status = status
        self.title = title
    }
    
    func getIconName() -> String {
        switch self.status {
        case "สินค้าอยู่ในระหว่างการซ่อม":
            return "black-wrench"
        case "อยู่ในระหว่างการจัดส่งสินค้า":
            return "delivery"
        case "รออะไหล่สินค้า":
            return "storage"
        case "บริษัทกำลังตรวจสอบสินค้า":
            return "verification"
        case "บริษัทได้รับสินค้าแล้ว":
            return "receiver"
        case "สินค้าไม่อยู่ในเงื่อนไขการรับซ่อม":
            return "denied"
        default:
            return ""
        }
    }
}
