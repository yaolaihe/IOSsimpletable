//
//  SaveLink.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit

class SaveLink: UITableViewController {

    @IBOutlet var saveMark: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [YoutubeMark] = []//creating a new empty list of NewRecipe object,: is the type
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    
    func getData() { //fetching part
        do {
            tasks = try context.fetch(YoutubeMark.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as! LinkCell
        //let cell = NewRecipeCell()
        let task = tasks[indexPath.row]
        cell.youtubeId = task.link
        cell.linkLink.text = "https://www.youtube.com/watch?v="+task.link!
        cell.linkTitle.text = task.name
        return cell
    }
    
    
    /*func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return 1
     }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(YoutubeMark.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
        
        //let tableviewSelf = self
        let optionMenu = UIAlertController(title: "Do you want to check Youtube Video", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default)
        {action in
            // Also action dismisses AlertController when pressed
            let openViewController = self.storyboard?.instantiateViewController(withIdentifier: "youtubeDisplay")as! YoutubenewViewController
            let cell = self.tableView.cellForRow(at: indexPath) as! LinkCell
            openViewController.youtubeName = cell.linkTitle.text
            openViewController.youtubeId = cell.youtubeId
            self.present(openViewController, animated: true)
            // When press "OK" button, present logInViewController
        }
        
        optionMenu.addAction(okayAction)
        optionMenu.addAction(cancelAction)
        present(optionMenu, animated: true, completion: nil)
        
        
        /*UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
         message:@"This is an alert."
         preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
         handler:^(UIAlertAction * action) {}];
         
         [alert addAction:defaultAction];
         [self presentViewController:alert animated:YES completion:nil];*/
    }

    
}
