//
//  NavigationManager.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit


class NavigationManager: NSObject {
    
    private static func goToStoryboard(storyboardName: String, viewControllerId: String) -> Void{
        let app = UIApplication.sharedApplication().delegate!
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(viewControllerId)
        app.window?!.rootViewController = vc
        
        UIView.transitionWithView(app.window!!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { app.window?!.rootViewController = vc
        }, completion: nil)
    }
    
    static func goLogin() -> Void{
        NavigationManager.goToStoryboard("Welcome", viewControllerId: "LoginViewController")
    }
    
    static func goMain(){
        NavigationManager.goToStoryboard("Main", viewControllerId: "MainController")
    }
    
    

}
