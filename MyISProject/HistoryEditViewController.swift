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
    var dynamicGoodsList = [String]()
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var fixDateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var fixImageView: UIImageView!

    @IBOutlet weak var categoryTextField: IQDropDownTextField!
    @IBOutlet weak var goodTextField: IQDropDownTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker()
        self.categoryTextField.delegate = self
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
            self.categoryTextField.delegate?.textField!(self.goodTextField, didSelectItem: historyModel.type)
        }
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
        self.historyModel?.typeText = self.goodTextField.selectedItem!
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
        } else if (self.goodTextField.selectedItem == nil) {
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
        fixImageView.image = image.resizeImage(image: image, targetSize: CGSize(width: 300, height: 300))
        let oldValue = self.historyModel?.image
        self.historyModel?.image = UIImagePNGRepresentation(image)
        if self.historyModel?.image != oldValue {
            self.historyModel?.needUploadImage = true
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}

extension HistoryEditViewController: IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        guard let item = item else {
            return
        }
        switch item {
        case "เครื่องใช้ไฟฟ้าขนาดเล็ก":
            dynamicGoodsList = ["กระทะไฟฟ้า",
                                "กาต้มน้ำร้อน",
                                "เครื่องปั่น-คั้น-ผสม-สกัด",
                                "ไดร์เป่าผม-เครื่องหนีบผม",
                                "หม้อหุงข้าว-ตุ๋น-นึ่ง",
                                "เครื่องทำแซนวิช-ไข่ม้วน-ปิ้งขนมปัง",
                                "เครื่องชงกาแฟและอุปกรณ์",
                                "เครื่องกรองน้ำและอุปกรณ์",
                                "พัดลม",
                                "เตารีด",
                                "เครื่องใช้ไฟฟ้าขนาดเล็กอื่นๆ"]
            break
        case "เครื่องใช้ไฟฟ้าขนาดใหญ่":
            dynamicGoodsList = ["เครื่องล้างจาน",
                                "เครื่องอบผ้า",
                                "ตู้เย็นและตู้แช่แข็ง",
                                "เครื่องซักผ้า",
                                "เตาแก๊สแบบฝัง",
                                "เครื่องดูดควัน",
                                "ตู้แช่ไวน์",
                                "เตาไฟฟ้า",
                                "เตาแก๊ส",
                                "ไมโครเวฟและเตาอบ"]
            break
        case "โทรศัพท์มือถือ-แท็บเล็ตและอุปกรณ์":
            dynamicGoodsList = ["เบสิคโฟน-โทรศัพท์บ้าน", "สมาร์ทโฟน", "แท็บเล็ต", "แบตเตอรี่สำรอง-อุปกรณ์ชาร์จไฟ", "อุปกรณ์เสริมโทรศัพท์-แท็บเล็ต"]
            break
        case "คอมพิวเตอร์ & โน๊ตบุ๊ค":
            dynamicGoodsList = ["คอมพิวเตอร์", "โน๊ตบุ๊ค"]
            break
        case "ทีวี-เครื่องเสียงและเครื่องเกม":
            dynamicGoodsList = ["ทีวี", "เครื่องเสียง", "เครื่องเกม"]
            break
        case "กล้องและอุปกรณ์":
            dynamicGoodsList = ["กล้อง", "อุปกรณ์"]
            break
        default:
            break
        }
        self.goodTextField.itemList = dynamicGoodsList
        if let selectedIndex = dynamicGoodsList.index(of: self.historyModel!.typeText) {
            self.goodTextField.selectedRow = selectedIndex+1
        }
    }
}
