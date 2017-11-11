//
//  DetailWarrantyViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/15/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class DetailWarrantyViewController: UIViewController {
    var warrantyModel: WarrantyModel?
    
    @IBOutlet fileprivate weak var typeImageView: UIImageView!
    @IBOutlet fileprivate weak var brandLabel: UILabel!
    @IBOutlet fileprivate weak var modelLabel: UILabel!
    @IBOutlet fileprivate weak var serialNumberLabel: UILabel!
    @IBOutlet fileprivate weak var buyDateLabel: UILabel!
    @IBOutlet fileprivate weak var buyLocationLabel: UILabel!
    @IBOutlet fileprivate weak var priceLabel: UILabel!
    @IBOutlet fileprivate weak var receiptImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let warrantyModel = self.warrantyModel else {
            return
        }
        self.typeImageView.image = UIImage(named: warrantyModel.type)
        self.brandLabel.text = warrantyModel.brand
        self.modelLabel.text = warrantyModel.model
        self.serialNumberLabel.text = warrantyModel.serialNumber
        self.buyDateLabel.text = warrantyModel.getDate()
        self.buyLocationLabel.text = warrantyModel.buyLocation
        self.priceLabel.text = warrantyModel.price
        if let publicId = warrantyModel.receiptImageId {
            self.receiptImageView.cldSetImage(publicId: publicId, cloudinary: cld)
        }
    }
    
    @IBAction func tapEditButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailQRViewController") as! ShowDetailQRViewController
        viewController.warrantyModel = self.warrantyModel
        self.navigationController?.pushViewController(viewController, animated: true)
     }
}
