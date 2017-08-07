//
//  AddWarrantyViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/15/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
var Products = ["ทีวี","ตู้เย็น","ไมโครเวฟ","มือถือ"]
var Price = [12000,8500,2500,25000]
var ProductIndex = 0
var price = [12000,8500,2500,25000]

class AddWarrantyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{


    @IBOutlet weak var ProductTableView: UITableView!
    //ปุ่ม edit
    //@IBOutlet weak var EditBtn: UIBarButton!
    
    @IBAction func Edit(_ sender: Any) {
        ProductTableView.isEditing = !ProductTableView.isEditing
//        switch ProductTableView.isEditing {
//        case true:
//            EditBtn.title = "แก้ไขรายการ"
//        case false:
//            EditBtn.title = "เรียบร้อย"
//        }
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // แสดงrowเท่ากับข้อมูลที่มี
        return Products.count
    }
    //ดึงข้อมูลมาแสดงที่  table view
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        
        cell.ProductImage?.image = UIImage(named:(Products[indexPath.row]+".jpg"))
        cell.ProductNameLbl?.text = Products[indexPath.row]
        cell.PriceLbl?.text = "สินค้าราคา \(Price[indexPath.row]) บาท"
        return cell
    }
    
    //click เลือกสินค้า แล้วจะไปแสดงหน้ารายละเอียด
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ProductIndex = indexPath.row
        performSegue(withIdentifier: "GoToDetailProductSegue", sender: self)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let image = UIImage(named: "navigator.png")
        //navigationItem.titleView = UIImageView(image: image)
       // let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
     //   imageView.contentMode = .scaleAspectFit
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
