//
//  RecipenewTableViewCell.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit

class RecipenewTableViewCell: UITableViewCell {
    @IBOutlet var recipeNames:UILabel!
    @IBOutlet var typeLabel:UILabel!
    @IBOutlet weak var recipeImages: UIImageView!
    var youtubeId : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
