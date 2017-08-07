//
//  ShowDetailQRViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/18/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class ShowDetailQRViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var BrandTxt: UITextField!
    @IBOutlet weak var SerialTxt: UITextField!
    @IBOutlet weak var ModelTxt: UITextField!
    @IBOutlet weak var NameTxt: UITextField!
    @IBOutlet weak var EmailTxt: UITextField!
    @IBOutlet weak var TelTxt: UITextField!
    @IBOutlet weak var DateTxt: UITextField!
    @IBOutlet weak var StoreName: UITextField!
    @IBOutlet weak var Price: UITextField!
    
    
    
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
        ConfirmQRPage.SerialInput = SerialTxt.text!
        ConfirmQRPage.ModelInput = ModelTxt.text!
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
        
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
