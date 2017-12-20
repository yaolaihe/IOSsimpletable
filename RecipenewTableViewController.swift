//
//  RecipenewTableViewController.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit

class RecipenewTableViewController: UITableViewController,UISearchBarDelegate {
    
    
    @IBOutlet weak var goback: UINavigationItem!
    
    

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var searchMap: UIBarButtonItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    @IBOutlet weak var saveList: UIButton!
    
    var recipeNames : [String] = []
    var recipeImages : [String] = []
    var recipeTypes : [String] = []
    var recipeIds : [String] = []
    var filteredData = [String]()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return recipeNames.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecipenewTableViewCell
        // Configure the cell...
        cell.recipeNames?.text = recipeNames[indexPath.row]
        asyncImage(cell: cell, img: recipeImages[indexPath.row])
        //cell.recipeImages?.image = UIImage(named: recipeImages[indexPath.row])
        cell.typeLabel?.text = recipeTypes[indexPath.row]
        cell.youtubeId = recipeIds[indexPath.row]
        //cell.thumbnailImageView.image = UIImage(named: recipeImages[indexPath.row])
        return cell
    }

    func asyncImage(cell : RecipenewTableViewCell, img:String) {
        let urlString = URL(string: img)
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    DispatchQueue.main.async {
                        cell.recipeImages.image = UIImage(data: data!)
                    }
                }
            }.resume()
            //http://stackoverflow.com/questions/4962561/set-uiimageview-image-using-a-url

        }
    }
    func search(query: String) {
        let q = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString = URL(string: "https://www.googleapis.com/youtube/v3/search?part=snippet&q=" + q! + "+recipe&key=AIzaSyAHc5bN1nmB48kxukALfWRIEyuKIlAwF24")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                        let items = parsedData["items"] as! [[String:Any]]
                        self.recipeNames.removeAll()
                        self.recipeImages.removeAll()
                        self.recipeTypes.removeAll()
                        self.recipeIds.removeAll()
                        //ar recipeNames = ["Breakfast","Salad","Beef/Steak","Desert"]
                        //var recipeImages = ["barrafina.jpg","upstate.jpg","caskpubkitchen.jpg","wafflewolf.jpg"]
                        for item in items {
                            let ids = item["id"] as! [String:Any]
                            let kind = ids["kind"] as! String
                            if kind == "youtube#video" {
                                let videoId = ids["videoId"] as! String
                                let snippet = item["snippet"] as! [String:Any]
                                let thumb = snippet["thumbnails"] as! [String:Any]
                                let thumbd = thumb["default"] as! [String:Any]
                                let dthumb = thumbd["url"] as! String
                                let title = snippet["title"] as! String
                                let desc = snippet["description"] as! String
                                print("id: \(videoId) img: \(dthumb) title: \(title) desc: \(desc)")
                                //self.asyncImage(i: self.recipeNames.count, img: dthumb)
                                self.recipeNames.append(title)
                                self.recipeImages.append(dthumb)
                                self.recipeTypes.append(desc)
                                self.recipeIds.append(videoId)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            search(query: query)
        }
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
            let cell = self.tableView.cellForRow(at: indexPath) as! RecipenewTableViewCell
            openViewController.youtubeName = cell.recipeNames.text
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
