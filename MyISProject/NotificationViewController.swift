//
//  NotificationViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var Notifications = [Notification]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // แสดงrowเท่ากับข้อมูลที่มี
        return Notifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        
        
        cell.notiLbl?.text = Notifications[indexPath.row].noti
        cell.NotiDetailLbl?.text = Notifications[indexPath.row].detail
        cell.NotiImage?.image = Notifications[indexPath.row].picture
        
        return cell
     
    }
    
   
    
    
    func CreateNotification(){
        let receive = Notification()
        receive.noti = "บริษัทได้รับสินค้าแล้ว"
        receive.detail = "ทีวีรุ่น Smart45"
        receive.picture = UIImage(named: "receiver")!
        Notifications.append(receive)
        
        let verifyProduct = Notification()
        verifyProduct.noti = "บริษัทกำลังตรวจสอบสินค้า"
        verifyProduct.detail = "ทีวีรุ่น Smart45"
        verifyProduct.picture = UIImage(named: "verification")!
        Notifications.append(verifyProduct)
        
        let storage = Notification()
        storage.noti = "รออะไหล่สินค้า"
        storage.detail = "ทีวีรุ่น Smart45"
        storage.picture = UIImage(named: "storage")!
        Notifications.append(storage)
        
        let delivery = Notification()
        delivery.noti = "อยู่ในระหว่างการจัดส่งสินค้า"
        delivery.detail = "ทีวีรุ่น Smart45"
        delivery.picture = UIImage(named: "delivery")!
        Notifications.append(delivery)
        
        let fix = Notification()
        fix.noti = "สินค้าอยู่ในระหว่างการซ่อม"
        fix.detail = "ทีวีรุ่น Smart45"
        fix.picture = UIImage(named: "black-wrench")!
        Notifications.append(fix)
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

         CreateNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
