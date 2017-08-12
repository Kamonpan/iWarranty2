//
//  ConfirmQRViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class ConfirmQRViewController: UIViewController {

    var warrantyModel: WarrantyModel?
    
    @IBOutlet fileprivate weak var BrandLbl: UILabel!
    @IBOutlet fileprivate weak var ModelLbl: UILabel!
    @IBOutlet fileprivate weak var SerialLbl: UILabel!
    @IBOutlet fileprivate weak var NameLbl: UILabel!
    @IBOutlet fileprivate weak var EmailLbl: UILabel!
    @IBOutlet fileprivate weak var TelLbl: UILabel!
    @IBOutlet fileprivate weak var DateLbl: UILabel!
    @IBOutlet fileprivate weak var StoreNameLbl: UILabel!
    @IBOutlet fileprivate weak var PriceLbl: UILabel!
    
    @IBAction func SendBtn(_ sender: Any) {
        let alert = UIAlertController(title: "success", message: "ทำรายการสำเร็จ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.okHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    func okHandler(alert: UIAlertAction!){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddWarrantyidentifier") as! AddWarrantyViewController
        navigationController?.pushViewController(vc,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let warrantyModel = self.warrantyModel else {
            return
        }
        BrandLbl.text = warrantyModel.brand
        SerialLbl.text = warrantyModel.serialNumber
        ModelLbl.text = warrantyModel.model
        NameLbl.text = ""
        EmailLbl.text = ""
        TelLbl.text = ""
        DateLbl.text = MyDateFormatter.string(from: warrantyModel.buyDate)
        StoreNameLbl.text = warrantyModel.buyLocation
        PriceLbl.text = warrantyModel.price
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
