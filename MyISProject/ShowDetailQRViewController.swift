//
//  ShowDetailQRViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/18/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class ShowDetailQRViewController: UIViewController ,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    @IBOutlet weak var BrandTxt: UITextField!
    @IBOutlet weak var SerialTxt: UITextField!
    @IBOutlet weak var ModelTxt: UITextField!
    @IBOutlet weak var NameTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var TelTxt: UITextField!
    @IBOutlet weak var DateTxt: UITextField!
    @IBOutlet weak var StoreName: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var PicImg: UIImageView!
    
    @IBAction func UploadPicBtn(_ sender: Any) {
        //        let image = UIImagePickerController()
        //        image.delegate = self
        //
        //        let alertPopup = UIAlertController(title: "Photo Source", message: "Choose a source",preferredStyle:.actionSheet)
        //
        //        alertPopup.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
        //            if UIImagePickerController.isSourceTypeAvailable(.camera){
        //                            image.sourceType = .camera
        //                                self.present(image,animated: true,completion: nil)
        //                            }
        //                            else{
        //                             print("Camera not available")
        //                            }
        //        }))
        //
        //        alertPopup.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
        //            image.sourceType = .photoLibrary
        //            self.present(image, animated: true, completion: nil)
        //
        //
        //        }))
        //
        //        alertPopup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //
        //            self.present(image, animated: true, completion: nil)
        //
        //        }
        //
        
        
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
        //function date
        let dataFormatter = DateFormatter()
        dataFormatter.dateStyle = .short
        dataFormatter.timeStyle = .none
        
        DateTxt.text = dataFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    // ------------------------------------------------------------------------
    //กดปุ่มแล้วพาไปให้อีกหน้า
    
    @IBAction func NextPage(_ sender: Any) {
        performSegue(withIdentifier: "ConfirmQRSegue", sender: self)
        
    }
    
    //pass ค่าไปให้อีกหน้า
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ConfirmQRPage = segue.destination as! ConfirmQRViewController
        
        ConfirmQRPage.BrandInput = BrandTxt.text!
        ConfirmQRPage.ModelInput = ModelTxt.text!
        ConfirmQRPage.SerialInput = SerialTxt.text!
        ConfirmQRPage.NameInput = NameTxt.text!
        ConfirmQRPage.EmailInput = EmailTxt.text!
        ConfirmQRPage.TelInput = TelTxt.text!
        ConfirmQRPage.DateInput = DateTxt.text!
        ConfirmQRPage.StoreNameInput = StoreName.text!
        ConfirmQRPage.PriceInput = Price.text!
        
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
        
        //datePicker เลือกวันที่
        DatePicker()
        
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
