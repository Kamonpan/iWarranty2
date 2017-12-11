//
//  HistoryDetailViewController.swift
//  MyISProject
//
//  Created by Jaruwit Sriburanasorn on 8/12/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    var historyModel: HistoryModel?
    
    @IBOutlet fileprivate weak var subjectLabel: UILabel!
    @IBOutlet fileprivate weak var modelLabel: UILabel!
    @IBOutlet fileprivate weak var serialNumberLabel: UILabel!
    @IBOutlet fileprivate weak var fixDateLabel: UILabel!
    @IBOutlet fileprivate weak var noteLabel: UILabel!
    @IBOutlet fileprivate weak var fixImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let historyModel = self.historyModel else {
            return
        }
        
        self.subjectLabel.text = historyModel.subject
        self.modelLabel.text = historyModel.model
        self.serialNumberLabel.text = historyModel.serialNumber
        self.fixDateLabel.text = historyModel.getDate()
        self.noteLabel.text = historyModel.note
        self.typeLabel.text = historyModel.type
        self.goodLabel.text = historyModel.typeText
        if let publicId = historyModel.imageId{
            self.fixImageView.cldSetImage(publicId: publicId, cloudinary: cld)
        }
    }

    @IBAction func tapEditButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryEditViewController") as! HistoryEditViewController
        self.historyModel?.image = UIImagePNGRepresentation(self.fixImageView.image)
        viewController.historyModel = self.historyModel
        viewController.isTextFieldsEditable = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
