//
//  HistoryTableViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var ProductHistory = ["ซ่อมทีวี","ซ่อมไอโฟน"]
    var DateTofix = ["17/9/2016","18/4/2017"]
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var HistoryTableView: UITableView!
    @IBAction func Edit(_ sender: Any) {
        HistoryTableView.isEditing = !HistoryTableView.isEditing
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // แสดงrowเท่ากับข้อมูลที่มี
        return ProductHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        
        cell.HistoryProductImage.image = UIImage(named:(ProductHistory[indexPath.row]+".jpg"))
        cell.HistoryProduct?.text = ProductHistory[indexPath.row]
        cell.DateToFixLbl?.text = DateTofix[indexPath.row]
        return cell
    }
    //click เลือกสินค้า แล้วจะไปแสดงหน้ารายละเอียด
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ProductIndex = indexPath.row
        performSegue(withIdentifier: "GoToDetailHistorySegue", sender: self)
    }
    
    //allows reordering of cell ไว้สำหรับเลื่อน cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = Products[sourceIndexPath.row]
        Products.remove(at:sourceIndexPath.row)
        Products.insert(item,at: destinationIndexPath.row)
        
    }
}
