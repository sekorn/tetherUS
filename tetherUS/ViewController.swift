//
//  ViewController.swift
//  tetherUS
//
//  Created by Scott on 10/24/15.
//  Copyright © 2015 Scott Kornblatt. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4
import FBSDKCoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func signInButtonPressed(sender: AnyObject) {
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile","email","user_about_me","user_friends"]) { (user:PFUser?, error:NSError?) -> Void in
            
            if (error != nil) {
                // display and alert message
                let myAlert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                return
            }
            
            //print(user)
            //print("Current user token=\(FBSDKAccessToken.currentAccessToken().tokenString)")
            //print("Current user id=\(FBSDKAccessToken.currentAccessToken().userID)")
            
            if (FBSDKAccessToken.currentAccessToken() != nil) {
                let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        
                let homeNavigationController = UINavigationController(rootViewController: homeViewController)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = homeNavigationController
                
            }
        }
    }
}

