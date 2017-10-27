//
//  SettingTableViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/30/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftOverlays

class SettingTableViewController: UITableViewController {
    let sections = ["Profile", "Setting"]
    let rows = ["Profile":
                        ["แก้ไขข้อมูลส่วนตัว","เปลี่ยนรหัสผ่าน"],
                "About":
                        ["ข้อตกลงและเงื่อนไขการใช้งาน","ติดต่อเรา","ออกจากระบบ"]
    ]
    
    
    @IBAction func CancelSettingBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func switchChanged(_ sender: UISwitch) {
        print(sender.isOn)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows[ sections[section] ]!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = rows[sections[indexPath.section]]![indexPath.row]
        cell.textLabel?.textColor = UIColor.darkGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Logout
        if indexPath.section == 1, indexPath.row == 2 {
            do {
                try Auth.auth().signOut()
                
                let loginViewController = self.storyboard!.instantiateViewController(withIdentifier: "ViewController")
                
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate

                UIView.transition(with: appDelegate.window!, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                    appDelegate.window?.rootViewController = loginViewController
                }, completion: { (_) in
                    
                })
            } catch {
                AlertHelper.showAlert(title: "Error", message: error.localizedDescription, ViewController: self)
            }
        // Reset password
        } else if indexPath.section == 0, indexPath.row == 1 {
            SwiftOverlays.showBlockingWaitOverlay()
            Auth.auth().sendPasswordReset(withEmail: (Auth.auth().currentUser?.email)!, completion: { (error) in
                SwiftOverlays.removeAllBlockingOverlays()
                AlertHelper.showAlert(title: "Success", message: "อีเมล์ได้ถูกส่งไปยังเมล์ของท่านแล้ว", ViewController: self)
            })
        // Edit profile
        } else if indexPath.section == 0, indexPath.row == 0 {
            let editProfileViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
            self.navigationController?.pushViewController(editProfileViewController, animated: true)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
