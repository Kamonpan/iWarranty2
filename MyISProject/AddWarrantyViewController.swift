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
import SwiftOverlays

class AddWarrantyViewController: UIViewController {
    
    var warrantyModelList = [WarrantyModel]()
    fileprivate let firebaseRef = Database.database().reference()
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBOutlet weak var ProductTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftOverlays.showBlockingWaitOverlay()
        
        firebaseRef.child("Warranties").observe(.value, with: { (snapshot) in
            var newItems = [WarrantyModel]()
            for item in snapshot.children {
                let snapshot = item as! DataSnapshot
                let warrantyModel = WarrantyModel(snapshot: snapshot)
                if warrantyModel.uid == self.getUid() {
                    newItems.append(warrantyModel)
                }
            }
            self.warrantyModelList = newItems
            self.ProductTableView.reloadData()
            SwiftOverlays.removeAllBlockingOverlays()
        })
        
    }
    
    @IBAction func Edit(_ sender: Any) {
        ProductTableView.isEditing = !ProductTableView.isEditing
    }
    
    @IBAction func tapAddWarrantyButton(_ sender: Any) {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            let showDetailQRViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailQRViewController") as! ShowDetailQRViewController
            
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

// MARK:- QRCodeDelegate
extension AddWarrantyViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        let resultsArray = result.value.components(separatedBy: " ")
        guard resultsArray.count == 2 else {
            AlertHelper.showAlert(title: "Error", message: "รูปแบบ QRCode ไม่ถูกต้อง", ViewController: self)
            return
        }
        let model = resultsArray[0]
        let serialNumber = resultsArray[1]
        let showDetailQRViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailQRViewController") as! ShowDetailQRViewController
        var warrantyModel = WarrantyModel()
        warrantyModel.model = model
        warrantyModel.serialNumber = serialNumber
        showDetailQRViewController.warrantyModel = warrantyModel
        self.navigationController?.pushViewController(showDetailQRViewController, animated: true)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        let showDetailQRViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowDetailQRViewController") as! ShowDetailQRViewController
        showDetailQRViewController.warrantyModel = WarrantyModel()
        self.navigationController?.pushViewController(showDetailQRViewController, animated: true)
    }
}

// MARK:- UITableView Datasource
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

// MARK:- UITableView Delegate

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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            firebaseRef.child("Warranties").child(self.warrantyModelList[indexPath.row].serialNumber).setValue(nil)
            self.warrantyModelList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
