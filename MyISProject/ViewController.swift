//
//  ViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/9/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

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
        let Username:String  = "111111"
        let Password:String  = "111111"
        
        // กรอกถูกต้อง
        if (EmailTxt.text == Username && PasswordTxt.text == Password){
//
//            constant().showAlert(title: "success", message: "Login success", ViewController: self)
//            return
            
            let GotoAddWarrantyTabbar = self.storyboard!.instantiateViewController(withIdentifier: "GotoAddWarrantyTabbar")
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            
            appDelegate.window?.rootViewController = GotoAddWarrantyTabbar
        }
        
            
        //แสดง popup error กรณีไม่ตรงเงื่อนไข
        else
        {
            //กรอกไม่ครบ 6 ตัวอักษร จะแสดง popup error
            
            if (EmailTxt.text!.characters.count<6) {
                
                EmailTxt.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
                constant().showAlert(title: "Error", message: "Email ต้องมากกว่า 6 ตัวอักษร", ViewController: self)
                return
            }
            else{
                EmailTxt.backgroundColor = UIColor.white
            }
            
            if (PasswordTxt.text!.characters.count<6) {
                PasswordTxt.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
                constant().showAlert(title: "Error", message: "Password ต้องมากกว่า 6 ตัวอักษร", ViewController: self)
                return
            }
            else{
                PasswordTxt.backgroundColor = UIColor.white
            }
            
            //กรอกไม่ถูกต้อง จะต้องแสดง popup error
            if (EmailTxt.text != Username && PasswordTxt.text != Password) {
                
                constant().showAlert(title: "Error", message: "Email หรือ Password ของคุณไม่ถูกต้อง", ViewController: self)
                return
            }
          

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        เรียกใช้การหุบ keyboard
       EmailTxt.delegate = self
        PasswordTxt.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

