//
//  AddEventViewController.swift
//  Remainders
//
//  Created by projas on 4/6/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit
import LKAlertController

protocol EditEventDetailDelegate {
    func editEventDetailDidUpdateEvent(controller: AddEventViewController) -> Void
}

class AddEventViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    @IBOutlet weak var notesArea: UITextView!
    
    var event: Event?
    var delegate: EditEventDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventDatePicker.minimumDate = NSDate()

        if event != nil {
            titleLabel.text = event?.title
            eventDatePicker.date = (event?.date)!
            notesArea.text = event?.note
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeModal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveEvent(sender: AnyObject) {

        if titleLabel.text == "" {
            Alert(title: "Error", message: "Please add a title for the event").addAction("OK").show()
            return
        }
        
        if eventDatePicker.date < 1.minutes.later {
            Alert(title: "Error", message: "Please set a future time").addAction("OK").show()
            return
        }
        
        let newEvent = Event(WithTitle: titleLabel.text!, date: eventDatePicker.date, note: notesArea.text!)
        if self.event == nil {
            //Save new event
            EventViewModel.saveNewEvent(newEvent, completion: {
                UILocalNotification.setNotificationWithEvent(newEvent)
            }, onFailure: { (error) in
                print(error.description)
            })
            
        }else{
            //Edit current event
            EventViewModel.updateEvent(self.event!, newEvent: newEvent, completion: {
                UILocalNotification.setNotificationWithEvent(self.event!)
                self.delegate?.editEventDetailDidUpdateEvent(self)
            }, onFailure: { (error) in
                    print(error.description)
            })
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}
