//
//  HistoryTableViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    var historyList = [HistoryModel]()

    @IBOutlet weak var HistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mockData()
    }
    
    func mockData() {
        for _ in 0..<3 {
            let data = HistoryModel(subject: "ซ่อมทีวี", brand: "Samsung", model: "ASN123", type: "ซ่อมทีวี", serialNumber: "OOO123", date: Date(), note: "Lorem Ipsum", image: nil)
            historyList.append(data)
        }
    }
    
    @IBAction func Edit(_ sender: Any) {
        HistoryTableView.isEditing = !HistoryTableView.isEditing
    }

}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        let history = historyList[indexPath.row]
        cell.HistoryProductImage.image = UIImage(named: history.type)
        cell.HistoryProduct.text = history.subject
        cell.DateToFixLbl.text = MyDateFormatter.string(from: history.date)
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryDetailViewController") as! HistoryDetailViewController
        viewController.historyModel = historyList[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = historyList[sourceIndexPath.row]
        historyList.remove(at:sourceIndexPath.row)
        historyList.insert(item,at: destinationIndexPath.row)
    }
}
