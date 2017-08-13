//
//  WarrantyModel.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation


struct WarrantyModel {
    var type: String = ""
    var brand: String = ""
    var model: String = ""
    var serialNumber: String = ""
    var buyDate: Date?
    var buyLocation: String = ""
    var price: String = ""
    var receipt: Data?
    
    init(type: String, brand: String, model: String, serialNumber: String, buyDate: Date?, buyLocation: String, price: String, receipt: Data?) {
        self.type = type
        self.brand = brand
        self.model = model
        self.serialNumber = serialNumber
        self.buyDate = buyDate
        self.buyLocation = buyLocation
        self.price = price
        self.receipt = receipt
    }
    
    init() {
        
    }
    
    func toAnyObject() -> Any {
        return [
            "type": type,
            "brand": brand,
            "model": model,
            "serialNumber": serialNumber,
            "buyDate": self.getDate(),
            "store": buyLocation,
            "price": price,
            "receipt": getReceipt()
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
