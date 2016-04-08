//
//  ViewController.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import RealmSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    var loginManager: FBSDKLoginManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonClicked() -> Void {
        self.loginManager = FBSDKLoginManager()
        self.loginManager.logInWithReadPermissions(["public_profile","email"], fromViewController: self) { (result, error) in
            if error != nil{
                print("Process error")
            }else if result.isCancelled {
                print("Cancelled")
            }else{
                self.getUserDataFromFacebook()
                
            }
        }
    }
    
    func getUserDataFromFacebook() -> Void {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, name"]).startWithCompletionHandler { (connection, result, error) in
            if error == nil{
                let dictionary = result as! [String : String]
                if let user = UserViewModel.getUserWithEmail(dictionary["email"]!){
                    UserViewModel.updateLoginState(user, isUserLogged: true)
                }else{
                    UserViewModel.saveUserIntoRealm(User(WithName: dictionary["name"]!, email: dictionary["email"]!, tokenId: dictionary["id"]!))
                }
                
                NavigationManager.goToStoryboard("Main", viewControllerId: "MainController")
            }else{
                print("Error getting facebook data...")
            }
        }
    }
    


    @IBAction func loginToFacebook(sender: AnyObject) {
        self.loginButtonClicked()
    }
}

