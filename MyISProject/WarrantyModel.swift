//
//  WarrantyModel.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct WarrantyModel {
    var type: String = ""
    var typeText: String = ""
    var brand: String = ""
    var model: String = ""
    var serialNumber: String = ""
    var buyDate: Date?
    var buyLocation: String = ""
    var price: String = ""
    var receipt: Data?
    var uid: String = ""
    
    init() {
        
    }
    
    init(type: String, typeText: String, brand: String, model: String, serialNumber: String, buyDate: Date?, buyLocation: String, price: String, receipt: Data?) {
        self.type = type
        self.typeText = typeText
        self.brand = brand
        self.model = model
        self.serialNumber = serialNumber
        self.buyDate = buyDate
        self.buyLocation = buyLocation
        self.price = price
        self.receipt = receipt
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.type = snapshotValue["type"] as! String
        self.typeText = snapshotValue["typeText"] as! String
        self.brand = snapshotValue["brand"] as! String
        self.model = snapshotValue["model"] as! String
        self.serialNumber = snapshotValue["serialNumber"] as! String
        self.buyDate = MyDateFormatter.date(from: snapshotValue["buyDate"] as! String)
        self.buyLocation = snapshotValue["store"] as! String
        self.price = snapshotValue["price"] as! String
        self.receipt = Data(base64Encoded: snapshotValue["receipt"] as! String)
        self.uid = snapshotValue["uid"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "type": type,
            "typeText": typeText,
            "brand": brand,
            "model": model,
            "serialNumber": serialNumber,
            "buyDate": self.getDate(),
            "store": buyLocation,
            "price": price,
            "receipt": getReceipt(),
            "uid": Auth.auth().currentUser?.uid
        ]
    }
    
    func getDate() -> String {
        if let date = self.buyDate {
            return MyDateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func getReceipt() -> String {
        if let data = self.receipt {
            return data.base64EncodedString()
        } else {
            return ""
        }
    }
}
