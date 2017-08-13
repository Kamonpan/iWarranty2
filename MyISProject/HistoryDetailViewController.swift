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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let historyModel = self.historyModel else {
            return
        }
        
        self.subjectLabel.text = historyModel.subject
        self.modelLabel.text = historyModel.model
        self.serialNumberLabel.text = historyModel.serialNumber
        self.fixDateLabel.text = MyDateFormatter.string(from: historyModel.date)
        self.noteLabel.text = historyModel.note
        if let data = historyModel.image {
            self.fixImageView.image = UIImage(data: data)
        }
    }

    @IBAction func tapEditButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryEditViewController") as! HistoryEditViewController
        viewController.historyModel = self.historyModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}