//
//  confirmRegister.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/15/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ConfirmRegisterViewController: UIViewController {

    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var EmailLbl: UILabel!
    @IBOutlet weak var PasswordLbl: UILabel!
    @IBOutlet weak var RePassLbl: UILabel!
    @IBOutlet weak var BirthLbl: UILabel!
    @IBOutlet weak var TelLbl: UILabel!
    @IBOutlet weak var AddressLbl: UILabel!
    @IBOutlet weak var SubDistrictLbl: UILabel!
    @IBOutlet weak var DistrictLbl: UILabel!
    @IBOutlet weak var ProvinceLbl: UILabel!
    @IBOutlet weak var ZipCodeLbl: UILabel!
    
    var userModel: UserModel?
    var firebaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userModel = self.userModel else {
            return
        }
        NameLbl.text = userModel.fullName
        EmailLbl.text = userModel.email
        PasswordLbl.text = userModel.password
        RePassLbl.text = userModel.password
        BirthLbl.text = MyDateFormatter.string(from: userModel.birthDate)
        TelLbl.text = userModel.phone
        AddressLbl.text = userModel.address
        SubDistrictLbl.text = userModel.tumbol
        DistrictLbl.text = userModel.amphur
        ProvinceLbl.text = userModel.province
        ZipCodeLbl.text = userModel.postcode
    }
    
    @IBAction func tapConfirmButton(_ sender: Any) {
        guard var userModel = self.userModel else {
            return
        }
        guard userModel.fullName != "" else {
            AlertHelper.showAlert(title: "Error", message: "กรุณาใส่ ชื่อ-นามสกุล", ViewController: self)
            return
        }
        
        Auth.auth().createUser(withEmail: userModel.email, password: userModel.password) { (user, error) in
            if let error = error {
                AlertHelper.showAlert(title: "Error", message: error.localizedDescription, ViewController: self)
            } else {
                userModel.uid = user!.uid
                let userRef = self.firebaseRef.child("Users").child(userModel.uid)
                userRef.setValue(userModel.toAnyObject())
                let alert = UIAlertController(title: "success", message: "ทำรายการสำเร็จ", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.okHandler))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func okHandler(alert: UIAlertAction!){
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
