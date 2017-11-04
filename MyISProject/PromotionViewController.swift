//
//  PromotionViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftOverlays

class PromotionViewController: UIViewController {
    
    var Brands = [Brand]()
    var promotionModelList = [Promotion]()
    
    fileprivate var firebase = Database.database().reference()

    @IBOutlet weak var PromoTableView: UITableView!
    @IBOutlet weak var BrandCollectionView: UICollectionView!

    @IBAction func tapProfileButton(_ sender: Any) {
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingTableViewController")
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBrand()
        
        PromoTableView.tableFooterView = UIView(frame: .zero)
        
        SwiftOverlays.showBlockingWaitOverlay()
        firebase.child("Promotions").observe(.value, with: { (snapshot) in
            var newItems = [Promotion]()
            for item in snapshot.children {
                let snapshot = item as! DataSnapshot
                let promotion = Promotion(snapshot: snapshot)
                newItems.append(promotion)
            }
            self.promotionModelList = newItems
            self.PromoTableView.reloadData()
            SwiftOverlays.removeAllBlockingOverlays()
        })
    }
    
    func createBrand(){
        
        let Brand1 = Brand()
        Brand1.picture = UIImage(named:"Canon")!
        Brand1.url = "http://www.canon.co.th/home?languageCode=TH"
        Brands.append(Brand1)
        
        let Brand2 = Brand()
        Brand2.picture = UIImage(named:"aj")!
        Brand2.url = "http://www.ajthai.com/"
        Brands.append(Brand2)
        
        let Brand3 = Brand()
        Brand3.picture = UIImage(named:"lg")!
        Brand3.url = "http://www.lg.com/th"
        Brands.append(Brand3)
        
        let Brand4 = Brand()
        Brand4.picture = UIImage(named:"powermall")!
        Brand4.url = "https://www.themall.co.th/promotion/254/POWER+MALL+ELECTRONICA"
        Brands.append(Brand4)
        
        let Brand5 = Brand()
        Brand5.picture = UIImage(named:"samsung")!
        Brand5.url = "http://www.samsung.com/th/"
        Brands.append(Brand5)
        
    }
    
}

extension PromotionViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotionModelList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        if let imageData = promotionModelList[indexPath.row].picture {
            cell.PromoImage?.image = UIImage(data: imageData)
        }
        
        return cell
    }
}

extension PromotionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promotion = promotionModelList[indexPath.row]
        let promotionDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PromoDetailViewController") as! PromoDetailViewController
        promotionDetailViewController.promotion = promotion
        self.present(promotionDetailViewController, animated: true, completion: nil)
    }
    
}


extension PromotionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.BrandImage?.image = Brands[indexPath.row].picture
        
        return cell
        
    }
}

extension PromotionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.barTintColor = UIColor(red: 1/255, green: 215/255, blue: 169/255, alpha: 1.0)
        viewController.brand = Brands[indexPath.row]
        self.present(navController, animated: true, completion: nil)
    }
}
