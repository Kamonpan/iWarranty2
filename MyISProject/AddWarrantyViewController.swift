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
import FirebaseDatabase

class AddWarrantyViewController: UIViewController {
    
    var warrantyModelList = [WarrantyModel]()
    private let firebaseRef = Database.database().reference()
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBOutlet weak var ProductTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.mockData()
        firebaseRef.child("Warranties").observe(.value, with: { (snapshot) in
            var newItems = [WarrantyModel]()
            for item in snapshot.children {
                let snapshot = item as! DataSnapshot
                let warrantyModel = WarrantyModel(snapshot: snapshot)
                newItems.append(warrantyModel)
            }
            self.warrantyModelList = newItems
            self.ProductTableView.reloadData()
        })
        
//        firebaseRef.observe(.value, with: { (snapshot) in
//            var warrantyItems = [WarrantyModel]()
//            for item in snapshot.children {
//                let postDict = snapshot.value as? [String: Any] ?? [:]
//                print(postDict.keys)
//                print("===")
//            }
//            
//        })
    }
    
    func mockData() {
        for _ in 0..<3 {
            let a = UIImagePNGRepresentation(#imageLiteral(resourceName: "ทีวี"))
            let data = WarrantyModel(type: "ทีวี",
                                     brand: "Toshiba",
                                     model: "ABFE",
                                     serialNumber: "123456",
                                     buyDate: Date(),
                                     buyLocation: "BigC",
                                     price: "1000",
                                     receipt: a!)
            self.warrantyModelList.append(data)
        }
    }
    
    @IBAction func Edit(_ sender: Any) {
        ProductTableView.isEditing = !ProductTableView.isEditing
    }
    
    @IBAction func tapAddWarrantyButton(_ sender: Any) {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let showDetailQRViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailQRViewController")
            self.navigationController?.pushViewController(showDetailQRViewController, animated: true)
        #else
        readerVC.delegate = self
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
        #endif
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

extension AddWarrantyViewController: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return warrantyModelList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        let warrantyModel = warrantyModelList[indexPath.row]
        cell.ProductImage?.image = UIImage(named: warrantyModel.type)
        cell.ProductNameLbl?.text = warrantyModel.brand
        cell.PriceLbl?.text = "สินค้าราคา \(warrantyModel.price) บาท"
        return cell
    }
}

extension AddWarrantyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailWarrantyViewController") as! DetailWarrantyViewController
        viewController.warrantyModel = warrantyModelList[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = warrantyModelList[sourceIndexPath.row]
        warrantyModelList.remove(at:sourceIndexPath.row)
        warrantyModelList.insert(item,at: destinationIndexPath.row)
    }
}
