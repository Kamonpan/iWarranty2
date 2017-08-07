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
        
        loadRequest(strUrl: brand.url)
    }

    func loadRequest(strUrl: String) {
        let url = URL(string: strUrl)!
        //let urlRequest = NSURLRequest(url: url as URL)
        //WebViewFrame.loadRequest(urlRequest as URLRequest)
        WebViewFrame.loadRequest(URLRequest(url: url))
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
