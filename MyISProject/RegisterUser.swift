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
          performSegue(withIdentifier: "GoToConfirmRegister", sender: self)
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
