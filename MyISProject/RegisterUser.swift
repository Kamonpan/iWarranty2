//
//  RegisterUser.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/13/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class RegisterUser: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var NameTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    @IBOutlet weak var RePassTxt: UITextField!
    @IBOutlet weak var BirthTxt: UITextField!
    @IBOutlet weak var TelTxt: UITextField!
    @IBOutlet weak var AddressTxt: UITextField!
    @IBOutlet weak var SubDistrictTxt: UITextField!
    @IBOutlet weak var DistrictTxt: UITextField!
    @IBOutlet weak var ProvinceTxt: UITextField!
    @IBOutlet weak var ZipCodeTxt: UITextField!
    
   

    @IBAction func NextBtn(_ sender: Any) {
        if(EmailTxt.text != nil){
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
            if (RePassTxt.text != PasswordTxt.text) {
                RePassTxt.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
                constant().showAlert(title: "Error", message: "กรุณาตรวจสอบ Password อีกครั้ง", ViewController: self)
                return
            }
            else{
                RePassTxt.backgroundColor = UIColor.white
            }
        }
        else{
            //check เพิ่มว่าทำไม pop upไม่ขึ้น หรือจะไม่เอาก้ได้ เก็บไว้ตอนทำ firebase
            
            let alert = UIAlertController(title: "Success",message: "ลงทะเบียนสำเร็จ",preferredStyle:.alert
            )
            let confirmRegister:ViewController = ViewController(nibName:"confirmRegister", bundle: nil)
            
            let resultAlert = UIAlertAction(title:"Ok",style:.default, handler:{
                (UIAlertAction) in
                self.present(confirmRegister, animated:true, completion:nil)

            })

               
   //back button
            
            
            
            
                
            alert.addAction(resultAlert)
            self.present(alert,animated: true, completion: nil)
                return
                    //กดปุ่มแล้วพาไปให้อีกหน้า
                    performSegue(withIdentifier: "GoToConfirmRegister", sender: self)
        }
        
    }
    
    //pass ค่าไปให้อีกหน้า
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ConfirmRegisterPage = segue.destination as! confirmRegister
        ConfirmRegisterPage.NameInput = NameTxt.text!
        ConfirmRegisterPage.EmailInput = EmailTxt.text!
        ConfirmRegisterPage.PasswordInput = PasswordTxt.text!
        ConfirmRegisterPage.RePassInput = RePassTxt.text!
        ConfirmRegisterPage.BirthInput = BirthTxt.text!
        ConfirmRegisterPage.TelInput = TelTxt.text!
        ConfirmRegisterPage.AddressInput = AddressTxt.text!
        ConfirmRegisterPage.SubDistrictInput = SubDistrictTxt.text!
        ConfirmRegisterPage.DistrictInput = DistrictTxt.text!
        ConfirmRegisterPage.ProvinceInput = ProvinceTxt.text!
        ConfirmRegisterPage.ZipcodeInput = ZipCodeTxt.text!
        
    }
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

        // Do any additional setup after loading the view.
        //เรียกใช้การหุบ keyboard
        NameTxt.delegate = self
        EmailTxt.delegate = self
        PasswordTxt.delegate = self
        RePassTxt.delegate = self
        BirthTxt.delegate = self
        TelTxt.delegate = self
        AddressTxt.delegate = self
        SubDistrictTxt.delegate = self
        DistrictTxt.delegate = self
        ProvinceTxt.delegate = self
        ZipCodeTxt.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
