//
//  newRecipeTableViewCell.swift
//  SimpleTable
//
//  Created by Fang Liu Frank on 5/3/17.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit

class newRecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeTitle: UILabel!
    
    func configureCell(task:NewRecipe){
        
        if let name = task.name {
            recipeTitle.text = name
            
            if let newIng = task.ingredients{
                print(newIng)
            }
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
