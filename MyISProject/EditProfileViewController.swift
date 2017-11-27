//
//  EditProfileViewController.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/14/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SwiftOverlays

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var tumbolTextField: UITextField!
    @IBOutlet weak var amphurTextField: UITextField!
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var postcodeTextField: UITextField!
    
    fileprivate let firebaseRef = Database.database().reference()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserInfo()
        DatePicker()
    }
    
    private func getUserInfo() {
        nameTextField.text = Session.shared.user.fullName
        emailTextField.text = Session.shared.user.email
        birthDateTextField.text = MyDateFormatter.string(from: Session.shared.user.birthDate)
        phoneTextField.text = Session.shared.user.phone
        addressTextField.text = Session.shared.user.address
        tumbolTextField.text = Session.shared.user.tumbol
        amphurTextField.text = Session.shared.user.amphur
        provinceTextField.text = Session.shared.user.province
        postcodeTextField.text = Session.shared.user.postcode
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
        self.birthDateTextField.inputAccessoryView = toolbar
        self.birthDateTextField.inputView = datePicker
    }
    
    func donePressed(){
        
        self.birthDateTextField.text = MyDateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @IBAction func tapConfirmButton(_ sender: Any) {
        SwiftOverlays.showBlockingWaitOverlay()
        if passwordTextField.text != "", rePasswordTextField.text != "", passwordTextField.text == rePasswordTextField.text {
            Session.shared.user.password = passwordTextField.text!
        }
        Session.shared.user.fullName = nameTextField.text!
        Session.shared.user.email = emailTextField.text!
        Session.shared.user.birthDate = MyDateFormatter.date(from: birthDateTextField.text!)
        Session.shared.user.phone = phoneTextField.text!
        Session.shared.user.address = addressTextField.text!
        Session.shared.user.tumbol = tumbolTextField.text!
        Session.shared.user.amphur = amphurTextField.text!
        Session.shared.user.province = provinceTextField.text!
        Session.shared.user.postcode = postcodeTextField.text!
        firebaseRef.child("Users").child(getUid()).setValue(Session.shared.user.toAnyObject())
        let alert = UIAlertController(title:title , message:"อัพเดทข้อมูลเรียบร้อย" , preferredStyle:.alert)
        let resultAlert = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(resultAlert)
        self.present(alert, animated: true, completion: nil)
        SwiftOverlays.removeAllBlockingOverlays()
    }

}
