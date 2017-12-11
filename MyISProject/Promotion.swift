//
//  Promotion.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Promotion {
    var picture: String?
    var addedAt: Double?
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        if let pictureId = snapshotValue["pictureId"] as? String {
            self.picture = pictureId
        }
        if let addedAt = snapshotValue["added_at"] as? Double {
            self.addedAt = addedAt
        }
        

    }
}
