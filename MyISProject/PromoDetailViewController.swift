//
//  PromoDetailViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/29/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class PromoDetailViewController: UIViewController {

    @IBOutlet weak var PromoImage: UIImageView!
    
    var Promo = Promotion()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PromoImage.image = Promo.pictureDetail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   }
