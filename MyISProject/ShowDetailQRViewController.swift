//
//  ShowDetailQRViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/18/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import IQDropDownTextField

class ShowDetailQRViewController: UIViewController ,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    var warrantyModel: WarrantyModel?
    
    private let categoryList = ["เครื่องใช้ไฟฟ้าขนาดเล็ก",
                                "เครื่องใช้ไฟฟ้าขนาดใหญ่",
                                "โทรศัพท์มือถือ-แท็บเล็ตและอุปกรณ์",
                                "คอมพิวเตอร์ & โน๊ตบุ๊ค",
                                "ทีวี-เครื่องเสียงและเครื่องเกม",
                                "กล้องและอุปกรณ์"]
    var dynamicGoodsList = [String]()
    var isTextFieldsEditable = true
    
    @IBOutlet fileprivate weak var BrandTxt: UITextField!
    @IBOutlet fileprivate weak var SerialTxt: UITextField!
    @IBOutlet fileprivate weak var ModelTxt: UITextField!
    @IBOutlet fileprivate weak var NameTxt: UITextField!
    @IBOutlet fileprivate weak var CategoryTxt: IQDropDownTextField!
    @IBOutlet fileprivate weak var GoodTxt: IQDropDownTextField!
    @IBOutlet fileprivate weak var DateTxt: UITextField!
    @IBOutlet fileprivate weak var StoreName: UITextField!
    @IBOutlet fileprivate weak var Price: UITextField!
    @IBOutlet fileprivate weak var PicImg: UIImageView!
    
    @IBAction func UploadPicBtn(_ sender: Any) {
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        PicImg.image = image.resizeImage(image: image, targetSize: CGSize(width: 300, height: 300))
        let oldValue = self.warrantyModel?.receipt
        self.warrantyModel?.receipt = UIImagePNGRepresentation(image)!
        if self.warrantyModel?.receipt != oldValue {
            self.warrantyModel?.needUploadImage = true
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    // -------------------------ทำ text field ให้เป็นวันที่-------------------------------------
    
    //datePicker
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
        DateTxt.inputAccessoryView = toolbar
        DateTxt.inputView = datePicker
    }
    func donePressed(){
        
        DateTxt.text = MyDateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    // ------------------------------------------------------------------------
    //กดปุ่มแล้วพาไปให้อีกหน้า
    
    @IBAction func NextPage(_ sender: Any) {
        performSegue(withIdentifier: "ConfirmQRSegue", sender: self)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (!self.validateTextFields()) {
            AlertHelper.showAlert(title: "Error", message: "กรุณากรอกข้อมูลให้ครบถ้วน", ViewController: self)
        }
        return validateTextFields()
        
    }
    
    //pass ค่าไปให้อีกหน้า
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let confirmQRPage = segue.destination as? ConfirmQRViewController {
            if var warrantyModel = self.warrantyModel {
                warrantyModel.brand = self.BrandTxt.text!
                warrantyModel.model = self.ModelTxt.text!
                warrantyModel.serialNumber = self.SerialTxt.text!
                warrantyModel.type = CategoryTxt.selectedItem!
                warrantyModel.typeText = GoodTxt.selectedItem!
                warrantyModel.buyDate = MyDateFormatter.date(from: self.DateTxt.text!)
                warrantyModel.buyLocation = self.StoreName.text!
                warrantyModel.price = self.Price.text!
                warrantyModel.receipt = UIImagePNGRepresentation(self.PicImg.image)
                confirmQRPage.warrantyModel = warrantyModel
            } else {
                var warrantyModel = WarrantyModel()
                warrantyModel.brand = self.BrandTxt.text!
                warrantyModel.model = self.ModelTxt.text!
                warrantyModel.serialNumber = self.SerialTxt.text!
                warrantyModel.type = CategoryTxt.selectedItem!
                warrantyModel.typeText = GoodTxt.selectedItem!
                warrantyModel.buyDate = MyDateFormatter.date(from: self.DateTxt.text!)
                warrantyModel.buyLocation = self.StoreName.text!
                warrantyModel.price = self.Price.text!
                warrantyModel.receipt = UIImagePNGRepresentation(self.PicImg.image)
                confirmQRPage.warrantyModel = warrantyModel
            }
            
        }
    }
    
    func validateTextFields() -> Bool {
        if (self.BrandTxt.text!.count <= 0) {
            return false
        } else if (self.ModelTxt.text!.count <= 0) {
            return false
        } else if (self.SerialTxt.text!.count <= 0) {
            return false
        } else if (self.CategoryTxt.selectedItem == nil) {
            return false
        } else if (self.GoodTxt.selectedItem == nil) {
            return false
        } else if (self.DateTxt.text!.count <= 0) {
            return false
        } else if (self.StoreName.text!.count <= 0) {
            return false
        } else if (self.Price.text!.count <= 0) {
            return false
        }
        return true
    }
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //กด return or enter จะหุบ keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatePicker()
        
        self.NameTxt.text = Session.shared.user.fullName
    
        //เรียกใช้การหุบ keyboard
        BrandTxt.delegate = self
        SerialTxt.delegate = self
        ModelTxt.delegate = self
        NameTxt.delegate = self
        DateTxt.delegate = self
        CategoryTxt.delegate = self
        StoreName.delegate = self
        Price.delegate = self
        
        CategoryTxt.itemList = categoryList
        
        guard let warrantyModel = self.warrantyModel else {
            return
        }
        
        if (!isTextFieldsEditable) {
            self.BrandTxt.isEnabled = false
            self.ModelTxt.isEnabled = false
            self.SerialTxt.isEnabled = false
            self.DateTxt.isEnabled = false
            self.CategoryTxt.isEnabled = false
            self.GoodTxt.isEnabled = false
            self.NameTxt.isEnabled = false
        }
        
        self.BrandTxt.text = warrantyModel.brand
        self.ModelTxt.text = warrantyModel.model
        self.SerialTxt.text = warrantyModel.serialNumber
        self.DateTxt.text = warrantyModel.getDate()
        self.StoreName.text = warrantyModel.buyLocation
        self.Price.text = warrantyModel.price
        if let selectedIndex = categoryList.index(of: warrantyModel.type) {
            self.CategoryTxt.selectedRow = selectedIndex+1
            self.CategoryTxt.delegate?.textField!(self.CategoryTxt, didSelectItem: warrantyModel.type)
        }
        
        if let receiptImageData = warrantyModel.receipt {
            self.PicImg.image = UIImage(data: receiptImageData)
        }
    }
    
}


extension ShowDetailQRViewController: IQDropDownTextFieldDelegate {
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
        self.GoodTxt.itemList = dynamicGoodsList
        if let selectedIndex = dynamicGoodsList.index(of: self.warrantyModel!.typeText) {
            self.GoodTxt.selectedRow = selectedIndex+1
        }
    }
}
