//
//  MainViewController.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MainViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.user = UserViewModel.getLoggedUser()
        nameLabel.text = user.name
        print("Name: "+user.name)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LogOut(sender: AnyObject) {
        UserViewModel.updateLoginState(self.user, isUserLogged: false)
        NavigationManager.goToStoryboard("Welcome", viewControllerId: "LoginViewController")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
