//
//  YoutubenewViewController.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit
import WebKit

class YoutubenewViewController: UIViewController,UIWebViewDelegate {
    
    @IBAction func doneButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = YoutubeMark(context: context) // Link Task & Context
        task.name = youtubeName
        task.link = youtubeId
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        do {
            try context.save()
        } catch {
            print("Could not save recipe")
        }
        self.navigationController?.popViewController(animated: true)
    }
   

    
    @IBOutlet weak var webView: UIWebView!
    var youtubeId : String?
    var youtubeName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //webView.delegate = self
        if let id = youtubeId {
            //https://youtu.be/Yua_BNweXgk
        if let electronicURL = URL(string:"https://www.youtube.com/watch?v="+id) {
            let electronicURLRequest = URLRequest(url: electronicURL)
            webView?.loadRequest(electronicURLRequest)
            //learned from WebView using Swift3 in ios 10 tutorial, https://www.youtube.com/watch?v=UFKBTiylaN4
        }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
