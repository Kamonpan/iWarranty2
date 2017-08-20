//
//  MyDateFormatter.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation

class MyDateFormatter {
    class func string(from date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    class func date(from string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-US")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let formatted = dateFormatter.date(from: string)
        return formatted
    }
}
