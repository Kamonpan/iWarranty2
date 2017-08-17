//
//  HistoryTableViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftOverlays

class HistoryViewController: UIViewController {
    
    var historyModelList = [HistoryModel]()
    fileprivate let firebaseRef = Database.database().reference()
    
    @IBOutlet weak var HistoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftOverlays.showBlockingWaitOverlay()
        firebaseRef.child("Histories").observe(.value, with: { (snapshot) in
            var newItems = [HistoryModel]()
            for item in snapshot.children {
                let snapshot = item as! DataSnapshot
                let historyModel = HistoryModel(snapshot: snapshot)
                newItems.append(historyModel)
            }
            self.historyModelList = newItems
            self.HistoryTableView.reloadData()
            SwiftOverlays.removeAllBlockingOverlays()
        })
        
    }
    
    @IBAction func Edit(_ sender: Any) {
        HistoryTableView.isEditing = !HistoryTableView.isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HistoryEditViewController {
            destination.historyModel = HistoryModel()
        }
    }
    
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        let history = historyModelList[indexPath.row]
        cell.HistoryProductImage.image = UIImage(named: history.type)
        cell.HistoryProduct.text = history.subject
        cell.DateToFixLbl.text = history.getDate()
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoryDetailViewController") as! HistoryDetailViewController
        viewController.historyModel = historyModelList[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            firebaseRef.child("Warranties").child(self.historyModelList[indexPath.row].serialNumber).setValue(nil)
            self.historyModelList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = historyModelList[sourceIndexPath.row]
        historyModelList.remove(at:sourceIndexPath.row)
        historyModelList.insert(item,at: destinationIndexPath.row)
    }
}
