//
//  HomeViewController.swift
//  tetherUS
//
//  Created by Scott on 11/11/15.
//  Copyright © 2015 Scott Kornblatt. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var findTetherButton: UIButton!
    @IBOutlet weak var findFriendsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupHomePage()
        
        self.findTetherButton.layer.cornerRadius = self.findTetherButton.frame.height/2
        self.findFriendsButton.layer.cornerRadius = self.findFriendsButton.frame.height/2
        
        self.animateAvatarImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findFriendsButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("segueFindFriends", sender: sender)
    }
    
    func animateAvatarImage() {
        
        UIView.animateWithDuration(2.0, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            
            self.avatarImageView.frame.origin.y = self.view.frame.height - self.avatarImageView.frame.height
            self.avatarImageView.layer.opacity = 1.0
            self.findTetherButton.layer.opacity = 1.0
            self.findFriendsButton.layer.opacity = 1.0
            
            }) { (complete) -> Void in
                
        }
    }
    
    func hideUIItems() {
        
        self.avatarImageView.layer.opacity = 0.0
        self.findTetherButton.layer.opacity = 0.0
        self.findFriendsButton.layer.opacity = 0.0
    }
    
    func GetFacebookDetails(user: PFUser) {
        
        let requestParameters = ["fields": "id, email, first_name, last_name, user_friends"]
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        
        userDetails.startWithCompletionHandler { (connection, result, error:NSError?) -> Void in
            
            if (error != nil) {
                print("\(error?.localizedDescription)")
                return
            }
            
            if (result != nil) {
                let userId:String = result["id"] as! String
                let userFirstName:String? = result["first_name"] as? String
                let userLastName:String? = result["last_name"] as? String
                let userEmail:String? = result["email"] as? String
                
                let myUser:PFUser = PFUser.currentUser()!
                myUser.setObject(userId, forKey: "facebookId")
                
                if (userFirstName != nil) {
                    myUser.setObject(userFirstName!, forKey: "first_name")
                }
                
                if (userLastName != nil) {
                    myUser.setObject(userLastName!, forKey: "last_name")
                }
                
                if (userEmail != nil) {
                    myUser.setObject(userEmail!, forKey: "email")
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    
                    let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    let profilePictureURL = NSURL(string: userProfile)
                    let profilePictureData = NSData(contentsOfURL: profilePictureURL!)
                    
                    self.avatarImageView.imageAvatar = UIImage(data: profilePictureData!)!
                    
                    
                    if (profilePictureData != nil) {
                        let profilePictureObject = PFFile(data: profilePictureData!)
                        myUser.setObject(profilePictureObject, forKey: "profile_picture")
                    }
                    
                    myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        
                        if (success) {
                            print("User details are now updated")
                        }
                    })
                }
            }
        }
        
    }
    
    func setupHomePage(){
        // Do any additional setup after loading the view.
        
        hideUIItems()
        
        let myUser:PFUser = PFUser.currentUser()!
        
        if myUser.isNew {
            // get details from social media
            GetFacebookDetails(myUser)
        } else {
            
            let pictureFile = myUser.objectForKey("profile_picture")
            pictureFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
                if (error == nil) {
                    self.avatarImageView.imageAvatar = UIImage(data: data!)
                }
            })
        }
    }
}
