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
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var fixDateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var fixImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let historyModel = self.historyModel else {
            return
        }
        
        self.brandTextField.text = historyModel.brand
        self.modelTextField.text = historyModel.model
        self.serialNumberTextField.text = historyModel.serialNumber
        self.fixDateTextField.text = MyDateFormatter.string(from: historyModel.date)
        self.noteTextField.text = historyModel.note
        if let data = historyModel.image {
            self.fixImageView.image = UIImage(data: data)
        }
    }

}
