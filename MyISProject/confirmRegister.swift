//
//  confirmRegister.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/15/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class confirmRegister: UIViewController {

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
    
    var NameInput = String()
    var EmailInput = String()
    var PasswordInput = String()
    var RePassInput = String()
    var BirthInput = String()
    var TelInput = String()
    var AddressInput = String()
    var SubDistrictInput = String()
    var DistrictInput = String()
    var ProvinceInput = String()
    var ZipcodeInput = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NameLbl.text = NameInput
        EmailLbl.text = EmailInput
        PasswordLbl.text = PasswordInput
        RePassLbl.text = RePassInput
        BirthLbl.text = BirthInput
        TelLbl.text = TelInput
        AddressLbl.text = AddressInput
        SubDistrictLbl.text = SubDistrictInput
        DistrictLbl.text = DistrictInput
        ProvinceLbl.text = ProvinceInput
        ZipCodeLbl.text = ZipcodeInput
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
