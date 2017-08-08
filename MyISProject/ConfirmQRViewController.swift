//
//  ConfirmQRViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class ConfirmQRViewController: UIViewController {

    @IBOutlet weak var BrandLbl: UILabel!
    @IBOutlet weak var ModelLbl: UILabel!
    @IBOutlet weak var SerialLbl: UILabel!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var EmailLbl: UILabel!
    @IBOutlet weak var TelLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!
    @IBOutlet weak var StoreNameLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBAction func SendBtn(_ sender: Any) {
        let alert = UIAlertController(title: "success", message: "ทำรายการสำเร็จ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.okHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    func okHandler(alert: UIAlertAction!){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddWarrantyidentifier") as! AddWarrantyViewController
        navigationController?.pushViewController(vc,animated: true)
    }
    
    var BrandInput = String()
    var SerialInput = String()
    var ModelInput = String()
    var NameInput = String()
    var EmailInput = String()
    var TelInput = String()
    var DateInput = String()
    var StoreNameInput = String()
    var PriceInput = String()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BrandLbl.text = BrandInput
        SerialLbl.text = SerialInput
        ModelLbl.text = ModelInput
        NameLbl.text = NameInput
        EmailLbl.text = EmailInput
        TelLbl.text = TelInput
        DateLbl.text = DateInput
        StoreNameLbl.text = StoreNameInput
        PriceLbl.text = PriceInput
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
