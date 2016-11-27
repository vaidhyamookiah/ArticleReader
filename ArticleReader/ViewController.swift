//
//  ViewController.swift
//  ArticleReader
//
//  Created by vaidhya mookiah on 26/11/16.
//  Copyright © 2016 Shakthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var ArticleTableView: UITableView! // TableView control
    
    @IBOutlet var LoadingIndicator: UIActivityIndicatorView! // Activity indicator animation when loading data from web
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

