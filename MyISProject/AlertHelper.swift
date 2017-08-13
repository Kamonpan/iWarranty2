//
//  AlertHelper.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/13/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import Foundation

class AlertHelper {
    class func showAlert(title:String , message:String , ViewController:UIViewController) {
        let alert = UIAlertController(title:title , message:message , preferredStyle:.alert)
        let resultAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(resultAlert)
        ViewController.present(alert, animated: true,   completion: nil)
    }
}
