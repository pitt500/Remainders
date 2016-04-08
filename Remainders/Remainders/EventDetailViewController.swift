//
//  EventDetailViewController.swift
//  Remainders
//
//  Created by projas on 4/7/16.
//  Copyright © 2016 projas. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
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
    
    
    private func setLabelsWithCurrentEvent() -> Void {
        eventTitleLabel.text = self.event.title
        eventDateLabel.text = String(self.event.date)
        eventDescriptionLabel.text = self.event.note
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
