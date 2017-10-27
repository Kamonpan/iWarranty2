//
//  ViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/9/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SwiftOverlays

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var UsernameLbl: UILabel!
    @IBOutlet weak var LogoImg: UIImageView!
    @IBOutlet weak var PasswordLbl: UILabel!
    @IBOutlet weak var RegisBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    
    fileprivate var firebaseRef: DatabaseReference!
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//กด return or enter จะหุบ keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let email = UserDefaults.standard.string(forKey: "lastRegisterEmail") {
            EmailTxt.text = email
        } else {
            EmailTxt.text = ""
            EmailTxt.placeholder = "กรุณากรอกอีเมล์"
        }
        PasswordTxt.text = "123456"
        
        EmailTxt.delegate = self
        PasswordTxt.delegate = self
        
        self.firebaseRef = Database.database().reference()
    }
    
//เงื่อนไขการ login
    @IBAction func Login(_sender: Any) {
        SwiftOverlays.showBlockingWaitOverlay()
        
        Auth.auth().signIn(withEmail: EmailTxt.text!, password: PasswordTxt.text!) { (user, error) in
            SwiftOverlays.removeAllBlockingOverlays()
            guard let user = user else {
                if let error = error {
                    AlertHelper.showAlert(title: "Error", message: error.localizedDescription, ViewController: self)
                    return
                }
                return
            }
            
            SwiftOverlays.showBlockingWaitOverlay()
            self.firebaseRef.child("Users").child(user.uid).observe(.value, with: { (snapshot) in
                Session.shared.user = UserModel(snapshot: snapshot)
            })
            SwiftOverlays.removeAllBlockingOverlays()

            let GotoAddWarrantyTabbar = self.storyboard!.instantiateViewController(withIdentifier: "GotoAddWarrantyTabbar")
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            
            appDelegate.window?.rootViewController = GotoAddWarrantyTabbar
        }
    }

}

