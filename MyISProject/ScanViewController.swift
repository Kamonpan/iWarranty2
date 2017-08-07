//
//  QRCodeGenerateViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/18/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//
import AVFoundation
import UIKit


class ScanViewController: UIViewController ,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
//    var reader: QRCodeReader = QRCodeReader()
//    var activityIndicator:UIActivityIndicatorView!
//    let session         : AVCaptureSession = AVCaptureSession()
//    var previewLayer    : AVCaptureVideoPreviewLayer!
//    var captureSession: AVCaptureSession!

    @IBOutlet weak var CropScan: UIImageView!
    @IBOutlet weak var SkipBtn: UIButton!
    @IBOutlet weak var ScanView: UIView!
    @IBAction func CancelScanBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
   
//        lazy var readerVC: QRCodeReaderViewController = {
//        let builder = QRCodeReaderViewControllerBuilder {
//            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
//            $0.showTorchButton = true
//        }
//        
//        return QRCodeReaderViewController(builder: builder)
//    }()
//    // MARK: - Actions
//    
//    public func checkScanPermissions() -> Bool {
//        do {
//            return try QRCodeReader.supportsMetadataObjectTypes()
//        } catch let error as NSError {
//            let alert: UIAlertController?
//            
//            switch error.code {
//            case -11852:
//                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
//                
//                alert?.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
//                    DispatchQueue.main.async {
//                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
//                            UIApplication.shared.openURL(settingsURL)
//                        }
//                    }
//                }))
//                
//                alert?.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//            case -11814:
//                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
//                alert?.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            default:
//                alert = nil
//            }
//            
//            guard let vc = alert else { return false }
//            
//            present(vc, animated: true, completion: nil)
//            
//            return false
//        }
//    }
//
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        func failed() {
//            let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
//            captureSession = nil
//        }
//
//        captureSession = AVCaptureSession()
//        
//        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//        let videoInput: AVCaptureDeviceInput
//        
//        do {
//            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
//        } catch {
//            return
//        }
//        
//        if (captureSession.canAddInput(videoInput)) {
//            captureSession.addInput(videoInput)
//        } else {
//            failed();
//            return;
//        }
//        
//        let metadataOutput = AVCaptureMetadataOutput()
//        
//        if (captureSession.canAddOutput(metadataOutput)) {
//            captureSession.addOutput(metadataOutput)
//            
//            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
//        } else {
//            failed()
//            return
//        }
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
//        previewLayer.frame = view.layer.bounds;
//        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        view.layer.addSublayer(previewLayer);
//        
//        captureSession.startRunning();
//        
//        
//        func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
//            reader.stopScanning()
//            
//            dismiss(animated: true) { [weak self] in
//                let alert = UIAlertController(
//                    title: "QRCodeReader",
//                    message: String (format:"%@ (of type %@)", result.value, result.metadataType),
//                    preferredStyle: .alert
//                )
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                
//                self?.present(alert, animated: true, completion: nil)
//            }
//        }
//        
//        func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
//            if let cameraName = newCaptureDevice.device.localizedName {
//                print("Switching capturing to: \(cameraName)")
//            }
//        }
//        
//}
//------------------------------
//
//        if !isSetView {
//            isSetView = true
//            
//            let value = UIInterfaceOrientation.landscapeLeft.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//            
//            // Allow the view to resize freely
//            self.highlightView.autoresizingMask =   [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin]
//            
//            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//            
//            do {
//                let input : AVCaptureDeviceInput? =  try AVCaptureDeviceInput(device: device)
//                session.addInput(input)
//            }
//            catch {
//                debugPrint(error)
//            }
//            
//            let output = AVCaptureMetadataOutput()
//            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            session.addOutput(output)
//            output.metadataObjectTypes = output.availableMetadataObjectTypes
//            
//            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.size.height/2, y: self.view.frame.size.width/2, width: 20.0, height: 20.0))
//            activityIndicator.isHidden = true
//            self.view.addSubview(activityIndicator)
//            
//            //Set Preview Layer
//            self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
//            self.view.layer.addSublayer(previewLayer)
//            self.view.bringSubview(toFront: CropScan)
//            self.view.bringSubview(toFront: SkipBtn)
//            
//            self.session.startRunning()
//        }
//    }
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        let screenSize = UIScreen.main.bounds.size
//        self.previewLayer.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
//        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        self.session.startRunning()
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        let value = UIInterfaceOrientation.portrait.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
//        
//        self.session.stopRunning()
//    }
//    
//    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait
//    }
//    override var shouldAutorotate : Bool {
//        return false
//    }
//    
//    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
//
//        func showErrorAlert(_ message:String){
//        let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: message, preferredStyle: .alert)
//        let action = UIAlertAction(title: "Ok", style: .cancel) { (action) -> Void in
//            
//        }
//        alert.addAction(action)
//
//        
//        self.present(alert, animated: true) { () -> Void in  }
//    }
//    
//    func transferQRPayment(_ refNumber: String) {
//        isScanSuccess = true
//        let vc:ShowDetailQRViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailQRViewController") as! ShowDetailQRViewController
//        vc.amount = self.amount
//        vc.refNumber = refNumber
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//
//    }
//
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
}
