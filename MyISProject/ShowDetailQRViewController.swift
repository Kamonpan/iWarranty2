//
//  ShowDetailQRViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/18/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class ShowDetailQRViewController: UIViewController ,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    var warrantyModel: WarrantyModel?
    
    @IBOutlet fileprivate weak var BrandTxt: UITextField!
    @IBOutlet fileprivate weak var SerialTxt: UITextField!
    @IBOutlet fileprivate weak var ModelTxt: UITextField!
    @IBOutlet fileprivate weak var NameTxt: UITextField!
    @IBOutlet fileprivate weak var EmailTxt: UITextField!
    @IBOutlet fileprivate weak var TelTxt: UITextField!
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
        PicImg.image = image
        self.warrantyModel?.receipt = UIImagePNGRepresentation(image)!
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
    
    //pass ค่าไปให้อีกหน้า
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let confirmQRPage = segue.destination as? ConfirmQRViewController {
            if var warrantyModel = self.warrantyModel {
                warrantyModel.brand = self.BrandTxt.text!
                warrantyModel.model = self.ModelTxt.text!
                warrantyModel.serialNumber = self.SerialTxt.text!
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
                warrantyModel.buyDate = MyDateFormatter.date(from: self.DateTxt.text!)
                warrantyModel.buyLocation = self.StoreName.text!
                warrantyModel.price = self.Price.text!
                warrantyModel.receipt = UIImagePNGRepresentation(self.PicImg.image)
                confirmQRPage.warrantyModel = warrantyModel
            }
            
        }
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
        guard let warrantyModel = self.warrantyModel else {
            return
        }
        self.BrandTxt.text = warrantyModel.brand
        self.ModelTxt.text = warrantyModel.model
        self.SerialTxt.text = warrantyModel.serialNumber
        self.NameTxt.text = ""
        self.EmailTxt.text = ""
        self.TelTxt.text = ""
        self.DateTxt.text = warrantyModel.getDate()
        self.StoreName.text = warrantyModel.buyLocation
        self.Price.text = warrantyModel.price
        if let data = Data(base64Encoded: warrantyModel.getReceipt()) {
            self.PicImg.image = UIImage(data: data)
        }
        
        
        
        //เรียกใช้การหุบ keyboard
        BrandTxt.delegate = self
        SerialTxt.delegate = self
        ModelTxt.delegate = self
        NameTxt.delegate = self
        EmailTxt.delegate = self
        TelTxt.delegate = self
        DateTxt.delegate = self
        StoreName.delegate = self
        Price.delegate = self
    }
    
    
}
