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
    private var _noti = ""
    var detail = ""
    var picture = UIImage()
    
    var noti:String{
        get {return _noti}
        set {_noti = newValue}
        
    }
}
