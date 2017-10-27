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
    var picture: Data?
    var pictureDetail: Data?
    
    init(snapshot: DataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.picture = Data(base64Encoded: snapshotValue["picture"] as! String)
        

    }
}
