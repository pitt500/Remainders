//
//  NavigationManager.swift
//  Remainders
//
//  Created by projas on 4/5/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import RealmSwift

class NavigationManager: NSObject {
    
    static func goToStoryboard(storyboardName: String, viewControllerId: String) -> Void{
        let app = UIApplication.sharedApplication().delegate!
        
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(viewControllerId)
        app.window?!.rootViewController = vc
        
        UIView.transitionWithView(app.window!!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { app.window?!.rootViewController = vc}, completion: nil)
    }

}
