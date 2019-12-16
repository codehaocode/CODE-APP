//
//  WebViewController.swift
//  CODE
//
//  Created by Yuhao Zhong on 16.12.19.
//  Copyright © 2019 CODE. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate
{
//    var webView: WKWebView!

@IBOutlet var codeWebsiteView: WKWebView!
    
    override func loadView() {
     let webConfiguration = WKWebViewConfiguration()
        codeWebsiteView = WKWebView(frame: .init(x: 0, y: 100, width: 414, height: 772), configuration: webConfiguration)
    codeWebsiteView.uiDelegate = self
        view = codeWebsiteView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.code.berlin")
        let myRequest = URLRequest(url:myURL!)
        codeWebsiteView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
