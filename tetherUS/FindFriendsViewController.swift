//
//  FindFriendsViewController.swift
//  tetherUS
//
//  Created by Scott on 11/9/15.
//  Copyright © 2015 Scott Kornblatt. All rights reserved.
//

import UIKit

class FindFriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        findFriends()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func findFriends() {
        let myUser = PFUser.currentUser()!
        
        let requestParameters = ["fields": "id, email, first_name, last_name"]
        let friendDetails = FBSDKGraphRequest(graphPath: "me/friends", parameters: requestParameters)
        
        friendDetails.startWithCompletionHandler { (connection, result, error:NSError?) -> Void in
            
            if (error == nil) {
                var friendObjects = result["data"] as! [NSDictionary]
                var friendIds: [NSString] = []
                
                for friendObject in friendObjects {
                    print(friendObject["id"] as! NSString)
                }
            }
            
        }
    }
}
