//
//  UIViewController+Extension.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/26/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

extension UIViewController {
    func getUid() -> String {
        if let Uid = Auth.auth().currentUser?.uid {
            return Uid
        } else {
            return ""
        }
    }
}
