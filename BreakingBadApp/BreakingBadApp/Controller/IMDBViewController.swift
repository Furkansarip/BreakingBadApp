//
//  IMDBViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import UIKit
import WebKit

class IMDBViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.imdb.com/title/tt0903747/"
        if let url = URL(string: urlString) {
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        }
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
                toolbarItems = [refresh]
                navigationController?.isToolbarHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           
        }
    

}
