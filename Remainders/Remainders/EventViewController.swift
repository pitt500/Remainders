//
//  EventViewController.swift
//  Remainders
//
//  Created by projas on 4/6/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class EventViewController: UITableViewController {
    
    var events = [Event]()
    var dateComparison: DateComparison = DateComparison.Today

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tabTitle: String = self.navigationController?.tabBarItem.title
            else{ return }
        
        self.dateComparison = (tabTitle == "Upcoming") ? .UpcomingEvents : .PastEvents
        
        if self.dateComparison == .UpcomingEvents {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showEventWithId), name: "kShowEventFromLocalNotification", object: nil)
        }
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        EventViewModel.getEventsForCurrentUser(dateComparison, completion: { (events) in
            self.events = events
            self.tableView.reloadData()
        }) { (error) in
            print(error.getMessage())
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        if self.dateComparison == .UpcomingEvents {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: "kShowEventFromLocalNotification", object: nil)
        }
    }
    
    //MARK: - NotificationCenter methods
    func showEventWithId(notification: NSNotification) -> Void {
        let id = notification.object as! String
        EventViewModel.getEventWithId(id, completion: { (event) in
            
            let now = NSDate()
            //We choose between upcoming tab or past tab (when user has selected a local notification later)
            self.tabBarController?.selectedIndex = (now <= event.date) ? 0 : 1
            
            let mainSB = UIStoryboard.init(name: "Main", bundle: nil)
            let detailVC = mainSB.instantiateViewControllerWithIdentifier("EventDetailViewController") as! EventDetailViewController
            detailVC.event = event
            self.navigationController?.pushViewController(detailVC, animated: true)
        }, onFailure: {(error) in
            print(error.getMessage())
        })
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
