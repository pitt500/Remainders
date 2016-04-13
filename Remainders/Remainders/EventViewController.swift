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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showEventWithDate), name: "kShowEventFromLocalNotification", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let tabTitle: String = self.navigationController?.tabBarItem.title
            else{ return }
        
        let dateComparison: DateComparison = (tabTitle == "Upcoming") ? .UpcomingEvents : .PastEvents
        EventViewModel.getEventsForCurrentUser(dateComparison, completion: { (events) in
            self.events = events
            self.tableView.reloadData()
        }) { (error) in
            print(error.description)
        }
        
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
        let date = notification.object as! NSDate
        EventViewModel.getEventWithDate(date, completion: { (event) in
            let mainSB = UIStoryboard.init(name: "Main", bundle: nil)
            let detailVC = mainSB.instantiateViewControllerWithIdentifier("EventDetailViewController") as! EventDetailViewController
            detailVC.event = event
            self.navigationController?.pushViewController(detailVC, animated: true)
        }, onFailure: {(error) in
            print(error.description)
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
