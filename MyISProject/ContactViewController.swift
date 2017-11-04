//
//  ContactViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/22/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import SwiftOverlays

class ContactViewController: UIViewController {

    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPhoneLabel: UILabel!
    @IBOutlet weak var companyWorkingHoursLabel: UILabel!
    
    fileprivate var firebaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    @IBAction func tapSearchButton(_ sender: Any) {
        SwiftOverlays.showBlockingWaitOverlay()
        firebaseRef.child("ServiceCenter").child(postcodeTextField.text!).observe(.value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: AnyObject] else {
                SwiftOverlays.removeAllBlockingOverlays()
                AlertHelper.showAlert(title: "Error", message: "ไม่พบศูนย์บริการ", ViewController: self)
                return
            }
            let serviceCenter = ServiceCenterModel(snapshotValue: data)
            self.companyNameLabel.text = serviceCenter.name
            self.companyPhoneLabel.text = serviceCenter.phone
            self.companyWorkingHoursLabel.text = serviceCenter.workingHours
            SwiftOverlays.removeAllBlockingOverlays()
        })
        
    }
    
    @IBAction func tapProfileButton(_ sender: Any) {
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingTableViewController")
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    

}
