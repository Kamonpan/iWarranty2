//
//  ServiceCenterModel.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 10/27/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ServiceCenterModel: NSObject {
    var name: String?
    var phone: String?
    var workingHours: String?
    var address: String?
    var postcode: String?
    
    init(snapshotValue: [String: AnyObject]) {
        self.name = snapshotValue["name"] as? String
        self.phone = snapshotValue["phone"] as? String
        self.workingHours = snapshotValue["workingHours"] as? String
        self.address = snapshotValue["address"] as? String
        self.postcode = snapshotValue["postcode"] as? String
    }
}
