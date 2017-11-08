//
//  NotificationViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftOverlays

class NotificationViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var Notifications = [Notification]()
    fileprivate let firebaseRef = Database.database().reference()
    fileprivate var displayData = [Notification]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // แสดงrowเท่ากับข้อมูลที่มี
        return self.displayData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        cell.notiLbl.text = self.displayData[indexPath.row].status
        cell.NotiDetailLbl.text = self.displayData[indexPath.row].title
        //cell.NotiImage =
        return cell
     
    }
    
    @IBAction func tapProfileButton(_ sender: Any) {
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingTableViewController")
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        firebaseRef.child("Warranties").observe(.value, with: { (snapshot) in
            for item in snapshot.children {
                let snapshot = item as! DataSnapshot
                let warrantyModel = WarrantyModel(snapshot: snapshot)
                if warrantyModel.uid == self.getUid() {
                    for (_, value) in warrantyModel.lastStatus {
                        if let value = value as? NSDictionary {
                            let date = value.object(forKey: "updatedAt") as! Double
                            let status = value.object(forKey: "status") as! String
                            let notification = Notification(date: date, status: status, title: warrantyModel.brand)
                            self.displayData.append(notification)
                        }
                    }
                }
            }
            self.displayData = self.displayData.sorted(by: { (a, b) -> Bool in
               return a.date! > b.date!
            })
            self.tableView.reloadData()
            SwiftOverlays.removeAllBlockingOverlays()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
