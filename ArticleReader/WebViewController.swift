//
//  WebViewController.swift
//  ArticleReader
//
//  Created by vaidhya mookiah on 26/11/16.
//  Copyright © 2016 Shakthi. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var WebURL : String?
    
    @IBOutlet var LoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet var WebViewer: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        WebViewer.delegate = self
        
        LoadingIndicator.hidesWhenStopped = true
    
        // Page to display when JSON doesnt have any URL
        let NoPageHtml : String! = "<h2 align =\"center\" style=\"font-family: Helvetica\">No Page to Display</h2>"
        
        if WebURL != nil {
            WebViewer.loadRequest(URLRequest(url: URL(string: WebURL!)!))
        }else {
            WebViewer.loadHTMLString(NoPageHtml, baseURL: nil)
        }
    
    }
    
// MARK: Action to main segue by pressing back button
    
    @IBAction func BackButtonPressed(_ sender: Any) {
        
        let MainController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as! ViewController

        let transition = SegueAnimation(Forward: false, Duration: 0.4)
        
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(MainController, animated: false, completion: nil)
   
    }

// MARK: WebView delegate functions
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        LoadingIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        LoadingIndicator.stopAnimating()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
