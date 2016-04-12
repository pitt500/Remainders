//
//  EventViewController.swift
//  Remainders
//
//  Created by projas on 4/6/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class EventViewController: UITableViewController {
    
    var events: [Event]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayBookDetailViewControllerWithNotification:) name:@"kDisplayBookDetail" object:nil];
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showEventWithDate), name: "kShowEventFromLocalNotification", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let tabTitle: String = self.navigationController?.tabBarItem.title
            else{ return }
        
        if tabTitle == "Upcoming" {
            self.events = EventViewModel.getEventsForUser(UserViewModel.getLoggedUser(), dateComparison: DateComparison.AfterToday)
        }else{
            self.events = EventViewModel.getEventsForUser(UserViewModel.getLoggedUser(), dateComparison: DateComparison.BeforeToday)
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "kShowEventFromLocalNotification", object: nil)
    }
    
    //MARK: - NotificationCenter methods
    func showEventWithDate(notification: NSNotification) -> Void {
        let mainSB = UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC = mainSB.instantiateViewControllerWithIdentifier("EventDetailViewController") as! EventDetailViewController
        let date = notification.object as! NSDate
        detailVC.event = EventViewModel.getEventWthDate(date, user: UserViewModel.getLoggedUser())
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: EventViewCell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventViewCell
        
        cell.configureCellWithEvent(self.events[indexPath.row])
        
        return cell
    }


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

    
    // MARK: - Navigation

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueEventDetail" {
            let detailVC = segue.destinationViewController as! EventDetailViewController
            let cell = sender as! EventViewCell
            let selectedIndexPath = self.tableView.indexPathForCell(cell)
            detailVC.event =  self.events[(selectedIndexPath?.row)!]
        }
        
        
        
    }
    

}
