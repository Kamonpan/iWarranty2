//
//  AddWarrantyViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/15/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

var Products = ["ทีวี","ตู้เย็น","ไมโครเวฟ","มือถือ"]
var Price = [12000,8500,2500,25000]
var ProductIndex = 0
var price = [12000,8500,2500,25000]

class AddWarrantyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
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
//    //ดึงข้อมูลมาแสดงที่  table view
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
    }
    
    @IBAction func tapAddWarrantyButton(_ sender: Any) {
        readerVC.delegate = self
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    @IBAction func tapProfileButton(_ sender: Any) {
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingTableViewController")
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension AddWarrantyViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        print(result)
        dismiss(animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        let showDetailQRViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailQRViewController")
        self.navigationController?.pushViewController(showDetailQRViewController, animated: true)
        dismiss(animated: true, completion: nil)
    }
}
