//
//  EventDetailViewController.swift
//  Remainders
//
//  Created by projas on 4/7/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import LKAlertController
import Timepiece

class EventDetailViewController: UIViewController, EditEventDetailDelegate {
    
    @IBOutlet private weak var eventTitleLabel: UILabel!
    @IBOutlet private weak var eventDateLabel: UILabel!
    @IBOutlet private weak var eventDescriptionLabel: UITextView!
    
    var event: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLabelsWithCurrentEvent()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController!.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController!.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteEvent(sender: AnyObject) {
        Alert(title: "Confirm", message: "Do you want to delete this event?")
            .addAction("Cancel")
            .addAction("Delete", style: .Destructive, handler: { _ in
                EventViewModel.deleteEvent(self.event)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }).show()
    }
    
    private func setLabelsWithCurrentEvent() -> Void {
        eventTitleLabel.text = self.event.title
        eventDateLabel.text = self.event.date.stringFromFormat("dd/MMM/yyyy hh:mm a")
        eventDescriptionLabel.text = self.event.note
    }
    
    // MARK: - Protocol methods
    func editEventDetailDidUpdateEvent(controller: AddEventViewController) {
        self.event = controller.event
        setLabelsWithCurrentEvent()
    }

    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueEditEvent" {
            let navController = segue.destinationViewController as! UINavigationController
            
            let editVC = navController.viewControllers.first as! AddEventViewController
            editVC.event =  self.event
            editVC.delegate = self
        }
        
        
    }
    

}
