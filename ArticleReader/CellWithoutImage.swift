//
//  CellWithoutImage.swift
//  ArticleReader
//
//  Created by vaidhya mookiah on 26/11/16.
//  Copyright © 2016 Shakthi. All rights reserved.
//

import UIKit

class CellWithoutImage: UITableViewCell {
    
    
    @IBOutlet var CellTitle: UILabel!
    
    @IBOutlet var CellAbstract: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
