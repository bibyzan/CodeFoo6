//
//  WebViewController.swift
//  ignApp
//
//  Created by Ben Rasmussen on 4/18/16.
//  Copyright © 2016 Ben Rasmussen. All rights reserved.
//

import UIKit

var currentURL: String = ""

class WebViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL (string: currentURL);
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
