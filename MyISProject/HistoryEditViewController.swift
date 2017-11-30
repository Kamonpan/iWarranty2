//
//  HistoryEditViewController.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import IQDropDownTextField

class HistoryEditViewController: UIViewController {
    
    var historyModel: HistoryModel?
    private let categoryList = ["เครื่องใช้ไฟฟ้าขนาดเล็ก",
                               "เครื่องใช้ไฟฟ้าขนาดใหญ่",
                               "โทรศัพท์มือถือ-แท็บเล็ตและอุปกรณ์",
                               "คอมพิวเตอร์ & โน๊ตบุ๊ค",
                               "ทีวี-เครื่องเสียงและเครื่องเกม",
                               "กล้องและอุปกรณ์"]
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var fixDateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var fixImageView: UIImageView!

    @IBOutlet weak var categoryTextField: IQDropDownTextField!
    @IBOutlet weak var goodTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.categoryTextField.itemList = categoryList
        guard let historyModel = self.historyModel else {
            return
        }
        self.subjectTextField.text = historyModel.subject
        self.brandTextField.text = historyModel.brand
        self.modelTextField.text = historyModel.model
        self.serialNumberTextField.text = historyModel.serialNumber
        if let selectedIndex = categoryList.index(of: historyModel.type) {
            self.categoryTextField.selectedRow = selectedIndex+1
        }
        self.goodTextField.text = historyModel.typeText
        self.fixDateTextField.text = historyModel.getDate()
        self.noteTextField.text = historyModel.note
        if let receiptImageData = historyModel.image {
            self.fixImageView.image = UIImage(data: receiptImageData)
        }
    }
    
    @IBAction func tapAttachButton(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapNextButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryConfirmViewController") as! HistoryConfirmViewController
        if (!self.validateTextFields()) {
            AlertHelper.showAlert(title: "Error", message: "กรุณากรอกข้อมูลให้ครบถ้วน", ViewController: self)
            return
        }
        self.historyModel?.subject = self.subjectTextField.text!
        self.historyModel?.brand = self.brandTextField.text!
        self.historyModel?.model = self.modelTextField.text!
        self.historyModel?.serialNumber = self.serialNumberTextField.text!
        self.historyModel?.type = self.categoryTextField.selectedItem!
        self.historyModel?.typeText = self.goodTextField.text!
        self.historyModel?.date = MyDateFormatter.date(from: self.fixDateTextField.text!)
        self.historyModel?.note = self.noteTextField.text!
        self.historyModel?.image = UIImagePNGRepresentation(self.fixImageView.image)
        viewController.historyModel = self.historyModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func validateTextFields() -> Bool {
        if (self.subjectTextField.text!.count <= 0) {
            return false
        } else if (self.brandTextField.text!.count <= 0) {
            return false
        } else if (self.modelTextField.text!.count <= 0) {
            return false
        } else if (self.serialNumberTextField.text!.count <= 0) {
            return false
        } else if (self.categoryTextField.selectedItem == nil) {
            return false
        } else if (self.goodTextField.text!.count <= 0) {
            return false
        } else if (self.fixDateTextField.text!.count <= 0) {
            return false
        } else if (self.noteTextField.text!.count <= 0) {
            return false
        }
        return true
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }

    
    let datePicker = UIDatePicker()
    
    func DatePicker(){
        //format date for picker
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done , target: nil ,action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        self.fixDateTextField.inputAccessoryView = toolbar
        self.fixDateTextField.inputView = datePicker
    }
    func donePressed(){
        
        self.fixDateTextField.text = MyDateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}

extension HistoryEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        fixImageView.image = image
        let oldValue = self.historyModel?.image
        self.historyModel?.image = UIImagePNGRepresentation(image)
        if self.historyModel?.image != oldValue {
            self.historyModel?.needUploadImage = true
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}
