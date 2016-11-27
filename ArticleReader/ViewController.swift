//
//  ViewController.swift
//  ArticleReader
//
//  Created by vaidhya mookiah on 26/11/16.
//  Copyright © 2016 Shakthi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var ArticleTableView: UITableView! // TableView control
    
    @IBOutlet var LoadingIndicator: UIActivityIndicatorView! // Activity indicator animation when loading data from web
    
    var ArticleObjectArray: [Article] = []
    
    let PullToRefresh = UIRefreshControl()
    
    let url = URL(string: "https://api.myjson.com/bins/51mx1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadingIndicator.hidesWhenStopped = true
        FetchData() // Function to fetch JSON data and store it in ArticleObjectArray
        
        ArticleTableView.delegate = self
        ArticleTableView.dataSource = self
        
        // Adding Pull to refresh gesture
        PullToRefresh.addTarget(self, action: #selector(RefreshTableView), for: .valueChanged)
        ArticleTableView.addSubview(PullToRefresh)

    }
    

// MARK: Fetch JSON data from the given URL
    
    func FetchData() {
        
        LoadingIndicator.startAnimating()
        // Fetching data from JSON URL
        let JsonTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print ("Error: Check URL ")
            }
            else
            {
                if let content = data
                {
                    do
                    {   // Reading JSON data
                        let ReceivedJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyObject]
                        
                        // Getting each article from article array
                        for ArticleJson in ReceivedJSON
                        {
                            let OneArtitle = Article()
                            let JsonTOSting = ArticleJson as! [String : String]
                         
                            OneArtitle.title = JsonTOSting["title"]
                            OneArtitle.abstract = JsonTOSting["abstract"]
                            OneArtitle.imageUrl = JsonTOSting["image_url"]
                            OneArtitle.WebURL = JsonTOSting["url"]
                            
                            self.ArticleObjectArray.append(OneArtitle)
                            let urlRequest = URLRequest(url: URL(string: OneArtitle.imageUrl!)!)
                            
                         // MARK: Check if the Image URL has Image and store the response in ImageStatusCode
                            
                            let ImageCheckTask = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
                                if error != nil {
                                    print(error ?? "Error receving image URL data")
                                    return
                                }
                                
                                let httpResponse = response as? HTTPURLResponse
                                OneArtitle.ImageStatusCode = (httpResponse?.statusCode)!
                            }
                            ImageCheckTask.resume()    
                        }
                    }
                    catch
                    {
                        print("Error reading JSON")
                    }
                    DispatchQueue.main.async {
                        self.ArticleTableView.reloadData()
                        self.LoadingIndicator.stopAnimating()
                    }
                }
            }
            
        }
        JsonTask.resume()

    }
    

// MARK: Fucntion to Refresh TableView when pulled down
    func RefreshTableView(){
        
        if PullToRefresh.isRefreshing {
            let formatter = DateFormatter()
            let date = Date()
            formatter.dateFormat = "MMM d, h:mm a"
            let title = "Last update: \(formatter.string(from: date as Date))"
            let attrsDictionary = NSDictionary(object: UIColor.blue, forKey: NSForegroundColorAttributeName as NSCopying)
            let attributedTitle = NSAttributedString(string: title, attributes: attrsDictionary as? [String : AnyObject]);
            PullToRefresh.attributedTitle = attributedTitle
            PullToRefresh.endRefreshing()
        }
        
        ArticleObjectArray.removeAll()
        FetchData()

    }
    
    
// MARK: Table View delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ArticleObjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if ArticleObjectArray[indexPath.item].ImageStatusCode != 404 {
        let ImagedProtoCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! CellWithImage
        ImagedProtoCell.CellDisplayImage.GetImageFromURL(from: ArticleObjectArray[indexPath.item].imageUrl!)
        ImagedProtoCell.CellTitle.text = ArticleObjectArray[indexPath.item].title
        ImagedProtoCell.CellAbstract.text = ArticleObjectArray[indexPath.item].abstract
            return ImagedProtoCell
        }else {
            let NoImagedProtoCell = tableView.dequeueReusableCell(withIdentifier: "NoImageCell", for: indexPath) as! CellWithoutImage
            NoImagedProtoCell.CellTitle.text = ArticleObjectArray[indexPath.item].title
            NoImagedProtoCell.CellAbstract.text = ArticleObjectArray[indexPath.item].abstract
            return NoImagedProtoCell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let WebController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebView") as! WebViewController
        WebController.WebURL = ArticleObjectArray[indexPath.item].WebURL
        let transition = SegueAnimation(Forward: true, Duration: 0.25)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(WebController, animated: false, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

