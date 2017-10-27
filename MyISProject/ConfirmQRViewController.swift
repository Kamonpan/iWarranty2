//
//  ConfirmQRViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftOverlays

class ConfirmQRViewController: UIViewController {

    var warrantyModel: WarrantyModel?
    var firebaseRef = Database.database().reference()
    
    @IBOutlet fileprivate weak var BrandLbl: UILabel!
    @IBOutlet fileprivate weak var ModelLbl: UILabel!
    @IBOutlet fileprivate weak var SerialLbl: UILabel!
    @IBOutlet fileprivate weak var NameLbl: UILabel!
    @IBOutlet fileprivate weak var CategoryLbl: UILabel!
    @IBOutlet fileprivate weak var GoodLbl: UILabel!
    @IBOutlet fileprivate weak var DateLbl: UILabel!
    @IBOutlet fileprivate weak var StoreNameLbl: UILabel!
    @IBOutlet fileprivate weak var PriceLbl: UILabel!
    @IBOutlet fileprivate weak var receiptImageView: UIImageView!
    
    @IBAction func SendBtn(_ sender: Any) {
        
        guard let warrantyModel = self.warrantyModel else {
            return
        }
        SwiftOverlays.showBlockingWaitOverlay()
        guard warrantyModel.serialNumber != "" else {
            SwiftOverlays.removeAllBlockingOverlays()
            AlertHelper.showAlert(title: "Error", message: "กรุณากรอกหมายเลขเครื่อง", ViewController: self)
            return
        }
        let warrantyRef = firebaseRef.child("Warranties").child(warrantyModel.serialNumber)
        warrantyRef.setValue(warrantyModel.toAnyObject())
        SwiftOverlays.removeAllBlockingOverlays()
        let alert = UIAlertController(title: "success", message: "ทำรายการสำเร็จ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.okHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func okHandler(alert: UIAlertAction!){
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let warrantyModel = self.warrantyModel else {
            return
        }
        BrandLbl.text = warrantyModel.brand
        SerialLbl.text = warrantyModel.serialNumber
        ModelLbl.text = warrantyModel.model
        NameLbl.text = Session.shared.user.fullName
        CategoryLbl.text = warrantyModel.type
        GoodLbl.text = warrantyModel.typeText
        DateLbl.text = warrantyModel.getDate()
        StoreNameLbl.text = warrantyModel.buyLocation
        PriceLbl.text = warrantyModel.price
        if let data = Data(base64Encoded: warrantyModel.getReceipt()) {
            self.receiptImageView.image = UIImage(data: data)
        }
    }
    
}
