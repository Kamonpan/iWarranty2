//
//  SettingTableViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/30/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingTableViewController: UITableViewController {
    let sections = ["Profile", "Setting"]
    let rows = ["Profile":
                        ["แก้ไขข้อมูลส่วนตัว","เปลี่ยนรหัสผ่าน"],
                     "Setting":
                        ["การแจ้งเตือน","แจ้งเตือนวันหมดอายุล่วงหน้า","ออกจากระบบ"]
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
        if indexPath.section == 1, indexPath.row == 0 {
            let theSwitch = UISwitch(frame: .zero)
            cell.addSubview(theSwitch)
            cell.accessoryView = theSwitch
            theSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        }
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
                print(error.localizedDescription)
            }
            
        } else if indexPath.section == 0, indexPath.row == 1 {
            let resetPWViewController = self.storyboard!.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
            self.navigationController?.pushViewController(resetPWViewController, animated: true)
        } else if indexPath.section == 0, indexPath.row == 0 {
            let editProfileViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
            self.navigationController?.pushViewController(editProfileViewController, animated: true)
        }
    }
    
}
