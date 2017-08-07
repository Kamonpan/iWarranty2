//
//  PromotionViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    var Brands = [Brand]()
    var Promotions = [Promotion]()
    
    func CreatePromotion(){
        let Promo1 = Promotion()
        Promo1.picture = UIImage(named: "powermallPromo")!
        Promo1.pictureDetail = UIImage(named: "powerMallDetail")!
        Promotions.append(Promo1)
        
        let Promo2 = Promotion()
        Promo2.picture = UIImage(named: "samsungPromo")!
        Promo2.pictureDetail = UIImage(named: "samsungPromoDetail")!
        Promotions.append(Promo2)
        
        let Promo3 = Promotion()
        Promo3.picture = UIImage(named: "washPromo")!
        Promo3.pictureDetail = UIImage(named: "washPromoDetail")!
        Promotions.append(Promo3)
    }
    
    func CreateBrand(){
        
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

    
    
    @IBOutlet weak var PromoTableView: UITableView!
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // แสดงrowเท่ากับข้อมูลที่มี
        return Promotions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewController
        
        cell.PromoImage?.image = Promotions[indexPath.row].picture
        
        return cell
    }
    //click เลือกสินค้า แล้วจะไปแสดงหน้ารายละเอียด
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ProductIndex = indexPath.row
        let Promotion = Promotions[indexPath.row]
        performSegue(withIdentifier: "GoToPromoViewSegue", sender: Promotion)
    }

    
    
    //-----------------------------------------------------------
    //collectionview brand
    @IBOutlet weak var BrandCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.BrandImage?.image = Brands[indexPath.row].picture
        
        return cell
        
    }
    //click เลือก brand แล้วจะไปแสดงหน้ารายละเอียด
    
    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: NSIndexPath) {
        let Brand = Brands[indexPath.row]
        performSegue(withIdentifier: "GoToWebViewSegue", sender: Brand)
    }
    //-----------------------------------------------------------
    
    //ส่งค่า pass segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPromoViewSegue"{
            
            if let PromoDetailViewController = segue.destination as? PromoDetailViewController{
                
                if let Promo1 = sender as? Promotion //as class Promotion
                {
                    PromoDetailViewController.Promo = Promo1
                }
            }
        }
        if segue.identifier == "GoToWebViewSegue" {
        //ส่ง url ของ brand ไป
            if let WebViewController = segue.destination as? WebViewController{
                
                if let Brands = sender as? Brand //as class
                {
                    WebViewController.brand = Brands

                }
            }
        
        }
        
    }
    

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateBrand()
        CreatePromotion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
