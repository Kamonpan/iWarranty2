//
//  ContactViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/22/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import SwiftOverlays

class ContactViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var postcodeTextField: UITextField!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyPhoneLabel: UILabel!
    @IBOutlet weak var companyWorkingHoursLabel: UILabel!
    
    var currentRegion: MKCoordinateRegion?
    
    fileprivate var firebaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.postcodeTextField.delegate = self
        self.mapView.delegate = self
    }
    
    @IBAction func tapSearchButton(_ sender: Any) {
        guard let postcode = postcodeTextField.text, postcode.count > 0 else {
            AlertHelper.showAlert(title: "Error", message: "กรุณากรอกศูนย์บริการ", ViewController: self)
            return
        }
        SwiftOverlays.showBlockingWaitOverlay()
        self.companyNameLabel.text = ""
        self.companyPhoneLabel.text = ""
        self.companyWorkingHoursLabel.text = ""
        firebaseRef.child("ServiceCenter").child(postcode).observe(.value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: AnyObject] else {
                SwiftOverlays.removeAllBlockingOverlays()
                AlertHelper.showAlert(title: "Error", message: "ไม่พบศูนย์บริการ", ViewController: self)
                return
            }
            let serviceCenter = ServiceCenterModel(snapshotValue: data)
            self.companyNameLabel.text = serviceCenter.name
            self.companyPhoneLabel.text = serviceCenter.phone
            self.companyWorkingHoursLabel.text = serviceCenter.workingHours
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(serviceCenter.address!) { [weak self] placemarks, error in
                if let placemark = placemarks?.first, let location = placemark.location {
                    let mark = MKPlacemark(placemark: placemark)
                    if var region = self?.mapView.region {
                        region.center = location.coordinate
                        region.span.longitudeDelta /= 8.0
                        region.span.latitudeDelta /= 8.0
                        self?.mapView.setRegion(region, animated: true)
                        self?.mapView.addAnnotation(mark)
                        self?.currentRegion = region
                    }
                }
            }
            SwiftOverlays.removeAllBlockingOverlays()
        })
        
    }
    
    @IBAction func tapProfileButton(_ sender: Any) {
        let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingTableViewController")
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @IBAction func tapGetDirection(_ sender: Any) {
        if(UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
            guard let region = self.currentRegion else {
                AlertHelper.showAlert(title: "Error", message: "ไม่สามารถเปิด Google Maps ได้", ViewController: self)
                return
            }
            UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=&daddr=\(region.center.latitude),\(region.center.longitude)")!, options: [:], completionHandler: nil)
        } else {
            AlertHelper.showAlert(title: "Error", message: "ไม่สามารถเปิด Google Maps ได้", ViewController: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

extension ContactViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(view)
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
    }
}
