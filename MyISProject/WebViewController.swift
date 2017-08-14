//
//  WebViewController.swift
//  MyISProject
//
//  Created by Kamonpan Ketlue on 7/28/2560 BE.
//  Copyright © 2560 Kamonpan Ketlue. All rights reserved.
//

import UIKit
class WebViewController: UIViewController {

    @IBOutlet weak var WebViewFrame: UIWebView!
    var brand = Brand()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.WebViewFrame.delegate = self
        loadRequest(strUrl: brand.url)
    }

    func loadRequest(strUrl: String) {
        let url = URL(string: strUrl)!
        WebViewFrame.loadRequest(URLRequest(url: url))
        
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
