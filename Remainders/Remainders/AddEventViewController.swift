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
        
        if event == nil {
            //Save new event
            let event = Event(WithTitle: titleLabel.text!, date: eventDatePicker.date, note: notesArea.text!)
            EventViewModel.saveEventIntoRealm(event)
            UserViewModel.saveUserEventIntoRealm(event)
            UILocalNotification.setNotificationWithEvent(event)
        }else{
            //Edit current event
            EventViewModel.updateEvent(event!, title: titleLabel.text!, date: eventDatePicker.date, notes: notesArea.text!)
            delegate?.editEventDetailDidUpdateEvent(self)
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
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
