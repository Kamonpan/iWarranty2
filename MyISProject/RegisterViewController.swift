//
//  RegisterUser.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/13/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var NameTxt: UITextField!
    @IBOutlet weak var GenderTxt: UITextField!
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
    
    let datePicker = UIDatePicker()

    @IBAction func NextBtn(_ sender: Any) {
        if PasswordTxt.text! != RePassTxt.text! {
            AlertHelper.showAlert(title: "Error", message: "รหัสผ่านไม่ตรงกัน", ViewController: self)
        } else {
            var userModel = UserModel()
            userModel.fullName = self.NameTxt.text!
            userModel.gender = self.GenderTxt.text!
            userModel.email = self.EmailTxt.text!
            userModel.password = self.PasswordTxt.text!
            userModel.birthDate = MyDateFormatter.date(from: self.BirthTxt.text!)
            userModel.phone = self.TelTxt.text!
            userModel.address = self.AddressTxt.text!
            userModel.tumbol = self.SubDistrictTxt.text!
            userModel.amphur = self.DistrictTxt.text!
            userModel.province = self.ProvinceTxt.text!
            userModel.postcode = self.ZipCodeTxt.text!
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "ConfirmRegisterViewController") as! ConfirmRegisterViewController
            viewController.userModel = userModel
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        
        DatePicker()
    }
    
    func DatePicker(){
        //format date for picker
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done , target: nil ,action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        self.BirthTxt.inputAccessoryView = toolbar
        self.BirthTxt.inputView = datePicker
    }
    
    func donePressed(){
        
        self.BirthTxt.text = MyDateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
