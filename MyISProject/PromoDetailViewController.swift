//
//  PromoDetailViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/29/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class PromoDetailViewController: UIViewController {
    
    var promotion: Promotion!
    
    @IBOutlet weak var PromoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PromoImage.image = UIImage(data: promotion.pictureDetail!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   }
