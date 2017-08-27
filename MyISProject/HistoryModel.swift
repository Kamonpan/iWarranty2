//
//  HistoryModel.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct HistoryModel {
    var subject: String = ""
    var brand: String = ""
    var type: String = ""
    var model: String = ""
    var serialNumber: String = ""
    var date: Date?
    var note: String = ""
    var image: Data?
    var uid: String = ""
    
    init() {}
    
    init(subject: String, type: String, brand: String, model: String, serialNumber: String, date: Date?, note: String, image: Data?) {
        self.subject = subject
        self.brand = brand
        self.model = model
        self.type = type
        self.serialNumber = serialNumber
        self.date = date
        self.note = note
        self.image = image
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.subject = snapshotValue["subject"] as! String
        self.type = "ซ่อมทีวี"
        self.brand = snapshotValue["brand"] as! String
        self.model = snapshotValue["model"] as! String
        self.serialNumber = snapshotValue["serialNumber"] as! String
        self.date = MyDateFormatter.date(from: snapshotValue["sendDate"] as! String)
        self.note = snapshotValue["note"] as! String
        self.image = Data(base64Encoded: snapshotValue["image"] as! String)
        self.uid = snapshotValue["uid"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "subject": self.subject,
            "type": self.type,
            "brand": self.brand,
            "model": self.model,
            "serialNumber": self.serialNumber,
            "sendDate": self.getDate(),
            "note": self.note,
            "image": self.getImage(),
            "uid": Auth.auth().currentUser?.uid
        ]
    }
    
    func getDate() -> String {
        if let date = self.date {
            return MyDateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    func getImage() -> String {
        if let data = self.image {
            return data.base64EncodedString()
        } else {
            return ""
        }
    }
    
}
