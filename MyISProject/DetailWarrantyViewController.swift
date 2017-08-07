//
//  DetailWarrantyViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/15/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class DetailWarrantyViewController: UIViewController {
//    var Products = ["ทีวี","ตู้เย็น","ไมโครเวฟ","มือถือ"]
//    var Price = [12000,8500,2500,25000]
//    var ProductIndex = 0
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductNameLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProductImage.image = UIImage(named:(Products[ProductIndex]+".jpg"))
        ProductNameLbl.text = Products[ProductIndex]
        PriceLbl.text = "สินค้าราคา \(Price[ProductIndex]) บาท"    }

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
