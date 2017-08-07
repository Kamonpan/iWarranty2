//
//  ConditionViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 8/5/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class ConditionViewController: UIViewController {
//แต่อยากให้กดกลับมาแล้วยังมี navigation bar , tab bar มา
    @IBAction func warrantyBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailWarrantyViewController") as! DetailWarrantyViewController
        self.present(vc, animated: true, completion: nil);

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
