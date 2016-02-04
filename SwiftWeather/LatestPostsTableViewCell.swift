//
//  LatestPostsTableViewCell.swift
//  SwiftWeather
//
//  Created by CB on 4/02/2016.
//  Copyright © 2016 Jake Lin. All rights reserved.
//

import UIKit

class LatestPostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
