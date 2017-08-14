//
//  HistoryEditViewController.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class HistoryEditViewController: UIViewController {
    
    var historyModel: HistoryModel?
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var fixDateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var fixImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker()
        guard let historyModel = self.historyModel else {
            return
        }
        self.subjectTextField.text = historyModel.subject
        self.modelTextField.text = historyModel.model
        self.serialNumberTextField.text = historyModel.serialNumber
        self.fixDateTextField.text = historyModel.getDate()
        self.noteTextField.text = historyModel.note
        if let data = historyModel.image {
            self.fixImageView.image = UIImage(data: data)
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
        self.historyModel?.subject = self.subjectTextField.text!
        self.historyModel?.model = self.modelTextField.text!
        self.historyModel?.serialNumber = self.serialNumberTextField.text!
        self.historyModel?.date = MyDateFormatter.date(from: self.fixDateTextField.text!)
        self.historyModel?.note = self.noteTextField.text!
        self.historyModel?.image = UIImagePNGRepresentation(self.fixImageView.image)
        viewController.historyModel = self.historyModel
        self.navigationController?.pushViewController(viewController, animated: true)
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
        picker.dismiss(animated: true, completion: nil)
        
    }
}
