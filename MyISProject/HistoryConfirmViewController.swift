//
//  HistoryConfirmViewController.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/14/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HistoryConfirmViewController: UIViewController {
    
    var historyModel: HistoryModel?
    
    fileprivate var firebaseRef = Database.database().reference()
    
    @IBOutlet weak var subjectTextField: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelTextField: UILabel!
    @IBOutlet weak var serialNumberTextField: UILabel!
    @IBOutlet weak var sendDateTextField: UILabel!
    @IBOutlet weak var noteTextField: UILabel!
    @IBOutlet weak var fixImageView: UIImageView!

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let historyModel = self.historyModel else {
            return
        }
        self.subjectTextField.text = historyModel.subject
        self.brandLabel.text = historyModel.brand
        self.modelTextField.text = historyModel.model
        self.serialNumberTextField.text = historyModel.serialNumber
        self.sendDateTextField.text = historyModel.getDate()
        self.noteTextField.text = historyModel.note
        self.categoryLabel.text = historyModel.type
        self.goodLabel.text = historyModel.typeText
        if let data = historyModel.image {
            self.fixImageView.image = UIImage(data: data)
        }
    }

    func okHandler(alert: UIAlertAction!){
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func tapReportButton(_ sender: Any) {
        guard let historyModel = self.historyModel else {
            return
        }
        guard historyModel.serialNumber != "" else {
            AlertHelper.showAlert(title: "Error", message: "กรุณากรอกหมายเลขเครื่อง", ViewController: self)
            return
        }
        let warrantyRef = firebaseRef.child("Histories").child(historyModel.serialNumber)
        warrantyRef.setValue(historyModel.toAnyObject())
        
        let alert = UIAlertController(title: "success", message: "ทำรายการสำเร็จ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: self.okHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
        AlertHelper.showAlert(title: "Success", message: "บันทึกรายการเรียบร้อย", ViewController: self)
    }
}
