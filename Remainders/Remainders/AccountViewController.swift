//
//  MainViewController.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import AlamofireImage

class AccountViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var upcomingEventsLabel: UILabel!
    var user: User!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserViewModel.getLoggedUserWithCompletion({ (user) in
            self.user = user
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            
            let url = NSURL(string: "https://graph.facebook.com/\(user.tokenId)/picture?type=large")!
            self.profileImageView.af_setImageWithURL(url)
        }) { (error) in
            print(error.getMessage())
        }
        
        
        EventViewModel.getEventsForCurrentUser(.UpcomingEvents, completion: { (events) in
            self.upcomingEventsLabel.text = String(events.count)
        }) { (error) in
            print(error.getMessage())
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LogOut(sender: AnyObject) {

        UserViewModel.updateLoginState(self.user, isUserLogged: false, completion: { 
            NavigationManager.goLogin()
        }) { (error) in
            print(error.getMessage())
        }
        
    }
    

}
