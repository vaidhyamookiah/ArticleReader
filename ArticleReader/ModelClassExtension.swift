//
//  ModelClassExtension.swift
//  ArticleReader
//
//  Created by vaidhya mookiah on 27/11/16.
//  Copyright © 2016 Shakthi. All rights reserved.
//

import UIKit


// MARK: Class to read JSON response from URL.

class Article: NSObject {
    
    // JSON response should be added
    var title: String?
    var abstract: String?
    var imageUrl: String?
    var WebURL: String?
    
    var ImageStatusCode: Int? // Status to indicate in Image is available or not
}


// MARK: Extension to download image from URL and add to UIImageView

extension UIImageView {
    func GetImageFromURL(from url: String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest)
        { (data,response,error) in
            if error != nil {
                print(error ?? "Error Getting URL")
                return
                }
            DispatchQueue.main.async
                {
                self.image = UIImage(data: data!)
                }
        }
        task.resume()
    }
}

// MARK: Segue Animation from Left to Right and vise versa

func SegueAnimation(Forward: Bool, Duration: CGFloat) -> CATransition {
    
    let transition = CATransition()
    transition.duration = CFTimeInterval(Duration)
    transition.type = kCATransitionPush
    if Forward {
        transition.subtype = kCATransitionFromRight
    }else {
        transition.subtype = kCATransitionFromLeft
    }
    
    return transition
}

// Mark: Extension to for alert in view controller
extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
