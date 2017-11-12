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
    var typeText: String = ""
    var model: String = ""
    var serialNumber: String = ""
    var date: Date?
    var note: String = ""
    var image: Data?
    var imageId: String?
    var uid: String = ""
    var lastStatus = NSDictionary()
    
    init() {}
    
    init(subject: String, type: String, typeText: String, brand: String, model: String, serialNumber: String, date: Date?, note: String, image: Data?) {
        self.subject = subject
        self.brand = brand
        self.model = model
        self.type = type
        self.typeText = typeText
        self.serialNumber = serialNumber
        self.date = date
        self.note = note
        self.image = image
    }
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.subject = snapshotValue["subject"] as! String
        self.type = snapshotValue["type"] as! String
        self.typeText = snapshotValue["typeText"] as! String
        self.brand = snapshotValue["brand"] as! String
        self.model = snapshotValue["model"] as! String
        self.serialNumber = snapshotValue["serialNumber"] as! String
        self.date = MyDateFormatter.date(from: snapshotValue["sendDate"] as! String)
        self.note = snapshotValue["note"] as! String
        if let imageId = snapshotValue["imageId"] as? String {
           self.imageId = imageId
        }
        self.uid = snapshotValue["uid"] as! String
        if let lastStatus = snapshotValue["lastStatus"] as? NSDictionary {
            self.lastStatus = lastStatus
        }
    }
    
    func toAnyObject() -> Any {
        return [
            "subject": self.subject,
            "type": self.type,
            "typeText": self.typeText,
            "brand": self.brand,
            "model": self.model,
            "serialNumber": self.serialNumber,
            "sendDate": self.getDate(),
            "note": self.note,
            "imageId": self.imageId,
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
