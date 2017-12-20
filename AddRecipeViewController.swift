//
//  AddRecipeViewController.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit

class AddRecipeViewController: UIViewController {

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeIngredients: UITextView!
    
    @IBOutlet weak var datePicker: UITextField!
    
    
    let datepicker = UIDatePicker()
    func createDatePicker(){
        
        // format
        datepicker.datePickerMode = .date
    
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
    
        //bar button item
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([donebutton], animated: false)
    
        datePicker.inputAccessoryView = toolbar
    
        //assigning date picker to text field
        datePicker.inputView = datepicker
        
    }
    
    func donePressed(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
    
        datePicker.text = dateFormatter.string(from: datepicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = NewRecipe(context: context) // Link Task & Context
        task.name = recipeTitle.text!
        task.ingredients = recipeIngredients.text!
        task.date = datePicker.text
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        do {
            try context.save()
        } catch {
            print("Could not save recipe")
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        //fixed problem with hide keyboard
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([flexibleSpace,doneButton], animated: false)

        recipeTitle.inputAccessoryView = toolBar
        recipeIngredients.inputAccessoryView = toolBar
       
    }
    
    func doneClicked(){
        view.endEditing(true)
    }

}
