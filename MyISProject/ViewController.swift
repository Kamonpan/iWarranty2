//
//  ViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/9/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var UsernameLbl: UILabel!
    @IBOutlet weak var LogoImg: UIImageView!
    @IBOutlet weak var PasswordLbl: UILabel!
    @IBOutlet weak var RegisBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//กด return or enter จะหุบ keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    
//เงื่อนไขการ login
    @IBAction func Login(_sender: Any) {
        
        Auth.auth().signIn(withEmail: EmailTxt.text!, password: PasswordTxt.text!) { (user, error) in
            guard let user = user else {
                if let error = error {
                    AlertHelper.showAlert(title: "Error", message: error.localizedDescription, ViewController: self)
                    return
                }
                return
            }

            let GotoAddWarrantyTabbar = self.storyboard!.instantiateViewController(withIdentifier: "GotoAddWarrantyTabbar")
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            
            appDelegate.window?.rootViewController = GotoAddWarrantyTabbar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailTxt.text = "a@a.com"
        PasswordTxt.text = "123456"

        EmailTxt.delegate = self
        PasswordTxt.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

