//
//  promotion.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import UIKit

class Promotion {
    var picture = UIImage()
    var pictureDetail = UIImage()

}
class Brand {
    var picture = UIImage()
    var url = ""
}

class Notification {
    private var _noti = ""
    var detail = ""
    var picture = UIImage()
    
    var noti:String{
        get {return _noti}
        set {_noti = newValue}

    }
}


