//
//  WebViewController.swift
//  ArticleReader
//
//  Created by vaidhya mookiah on 26/11/16.
//  Copyright © 2016 Shakthi. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet var LoadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func BackButtonPressed(_ sender: Any) {
        
        let MainController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as! ViewController

        let transition = SegueAnimation(Forward: false, Duration: 0.4)
        
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(MainController, animated: false, completion: nil)
        
        
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
