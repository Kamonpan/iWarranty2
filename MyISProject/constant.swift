//
//  constant.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import Foundation
import UIKit


class constant {
    func showAlert(title:String , message:String , ViewController:UIViewController) {
        let alert = UIAlertController(title:title , message:message , preferredStyle:.alert)
        let resultAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(resultAlert)
        ViewController.present(alert, animated: true,   completion: nil)
            }
    
    
}
