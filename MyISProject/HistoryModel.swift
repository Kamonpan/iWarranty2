//
//  HistoryModel.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
struct HistoryModel {
    
    var subject: String = ""
    var brand: String = ""
    var type: String = ""
    var model: String = ""
    var serialNumber: String = ""
    var date: Date
    var note: String = ""
    var image: Data?
    
    init(subject: String, brand: String, model: String, type: String, serialNumber: String, date: Date, note: String, image: Data?) {
        self.subject = subject
        self.brand = brand
        self.model = model
        self.type = type
        self.serialNumber = serialNumber
        self.date = date
        self.note = note
        self.image = image
    }
}
