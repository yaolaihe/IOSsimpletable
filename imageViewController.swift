//
//  imageViewController.swift
//  SimpleTable
//
//  Created by Fang Liu Frank.
//  Copyright © 2017 Fang Liu Frank. All rights reserved.
//
import UIKit
import Social

class imageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePickerContoller = UIImagePickerController()
        imagePickerContoller.delegate = self
        
        let actionSheet = UIAlertController(title: "Choose a source", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerContoller.sourceType = .camera
                self.present(imagePickerContoller, animated: true, completion: nil)
            }else {
                print("Camera is not available in your device")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerContoller.sourceType = .photoLibrary
            self.present(imagePickerContoller, animated: true, completion: nil)
            print("Viewing Library")
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func postToFacebook(_ sender: Any) {
        let facebookController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookController?.setInitialText("I am using SimpleTable.")
        facebookController?.add(imageView.image)
        self.present(facebookController!, animated: true, completion: nil)
    }
    
    
    @IBAction func postToWeibo(_ sender: Any) {
        if let weibo = SLComposeViewController(forServiceType: SLServiceTypeSinaWeibo){
            weibo.setInitialText("I am using SimpleTable.")
            weibo.add(imageView.image)
            self.present(weibo, animated:true, completion: nil)
        }
    }
    
    @IBAction func postToTwitter(_ sender: Any) {
        let twitterController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        twitterController?.setInitialText("I am using SimpleTable.")
        twitterController?.add(imageView.image)
        self.present(twitterController!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("Test code")
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
