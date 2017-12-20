//
//  RecipeDetailViewController.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import UserNotifications


class RecipeDetailViewController: UIViewController,UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        
        //I WANT TO DISPLAY THE CORE DATA INFORMATION FROM THE TABLE CELL I SELECTED.
        recipeTitle.text = recipe?.name
        recipeIngredients.text = recipe?.ingredients
        recipeIngredients.isUserInteractionEnabled = false
        dateCreated.text = recipe?.date
        
    }
    
    var recipe : NewRecipe?
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeIngredients: UITextView!
    @IBOutlet var dateCreated: UILabel!
    
    @IBAction func didAction(sender:UIButton) {
        //request Notification Setting
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
                switch notificationSettings.authorizationStatus {
                case.notDetermined:
                    self.requestAuthorization(completionHandler: { (success) in
                        guard success else { return }
                            
                        // Schedule Local Notification
                        self.scheduleLocalNotification()
                    })
                // Request Authorization
                case.authorized:
                // Schedule Local Notification
                    self.scheduleLocalNotification()
                case.denied:
                    print("Application Not Allowed to Display Notifications")
                }
            }
    }
    
    private func scheduleLocalNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "You have added one recipe"
    
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "local_notification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    // MARK: - Private Methods
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }

    @IBAction func readForMe(_ sender: Any) {
        if let read = recipeIngredients.text {
            let utterance = AVSpeechUtterance(string: read.replacingOccurrences(of: "\n", with: ","))
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.35
            utterance.volume = 1.0
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
            
        //https://www.hackingwithswift.com/example-code/media/how-to-convert-text-to-speech-using-avspeechsynthesizer-avspeechutterance-and-avspeechsynthesisvoice
        //SpeechSynthesizer employed for reading the ingredients
        }
    }

}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
}

