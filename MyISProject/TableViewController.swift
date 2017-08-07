//
//  AddWarrantyTableViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/15/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class TableViewController: UITableViewCell {
// หน้าเพิ่มใบรับประกัน addWarrantyViewController
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductNameLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!

// หน้าประวัติการแจ้งซ่อม historyViewController
    
    @IBOutlet weak var HistoryProductImage: UIImageView!
    @IBOutlet weak var HistoryProduct: UILabel!
    @IBOutlet weak var DateToFixLbl: UILabel!
 
    //หน้า Promotion
    
    @IBOutlet weak var PromoImage: UIImageView!

 //notification
    
    @IBOutlet weak var notiLbl: UILabel!
    @IBOutlet weak var NotiImage: UIImageView!
    @IBOutlet weak var NotiDetailLbl: UILabel!

}
