//
//  WebViewViewController.swift
//  Feed
//
//  Created by Maryam Alimohammadi on 2/22/20.
//  Copyright © 2020 Maryam Alimohammadi. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    public var videoSource: String?
    public var titleName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleName
        configWebView()
    }
    
    private func configWebView(){
        
        guard let url = URL(string: videoSource ?? "") else{
            return
        }
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
    }
  

}
