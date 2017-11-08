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
}
