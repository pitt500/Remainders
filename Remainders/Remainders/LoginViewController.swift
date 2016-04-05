//
//  ViewController.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonClicked() -> Void {
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile","email"], fromViewController: self) { (result, error) in
            if error != nil{
                print("Process error")
            }else if result.isCancelled {
                print("Cancelled")
            }else{
                print("Logged in")
                self.loginLabel.text = "Logged in!"
            }
        }
    }


    @IBAction func loginToFacebook(sender: AnyObject) {
        self.loginButtonClicked()
    }
}

