//
//  LinkCell.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit

class LinkCell: UITableViewCell {

    @IBOutlet weak var linkTitle: UILabel!
    
    @IBOutlet weak var linkLink: UILabel!
    
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
