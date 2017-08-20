//
//  UserModel.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/20/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import FirebaseDatabase
import Foundation

struct UserModel {
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var birthDate: Date?
    var phone: String = ""
    var address: String = ""
    var tumbol: String = ""
    var amphur: String = ""
    var province: String = ""
    var postcode: String = ""
    var uid: String = ""
    
    init() {
        
    }
    
    init(fullName: String, email: String, password: String, birthDate: Date?, phone: String, address: String, tumbol: String, amphur: String, province: String, postcode: String) {
        self.fullName = fullName
        self.email = email
        self.password = password
        self.birthDate = birthDate
        self.phone = phone
        self.address = address
        self.tumbol = tumbol
        self.amphur = amphur
        self.province = province
        self.postcode = postcode
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.fullName = snapshotValue["fullName"] as! String
        self.email = snapshotValue["email"] as! String
        self.password = snapshotValue["password"] as! String
        self.birthDate = MyDateFormatter.date(from: snapshotValue["birthDate"] as! String)
        self.phone = snapshotValue["phone"] as! String
        self.address = snapshotValue["address"] as! String
        self.tumbol = snapshotValue["tumbol"] as! String
        self.amphur = snapshotValue["amphur"] as! String
        self.province = snapshotValue["province"] as! String
        self.postcode = snapshotValue["postcode"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "fullName": self.fullName,
            "email": self.email,
            "password": self.password,
            "birthDate": MyDateFormatter.string(from: self.birthDate),
            "phone": self.phone,
            "address": self.address,
            "tumbol": self.tumbol,
            "amphur": self.amphur,
            "province": self.province,
            "postcode": self.postcode
        ]
    }
}
