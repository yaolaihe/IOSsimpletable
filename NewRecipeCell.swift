//
//  NewRecipeCell.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit

class NewRecipeCell: UITableViewCell {
    
    @IBOutlet weak var recipeTitle: UILabel!
    var recipe : NewRecipe?
    
    func configureCell(task:NewRecipe){
        recipe = task
        
        if let name = task.name {
            recipeTitle.text = name

            if let newIng = task.ingredients{
                print(newIng)
            }
        }
       
    }
}
