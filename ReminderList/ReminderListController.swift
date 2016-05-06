//
//  ReminderListController.swift
//  ReminderList
//
//  Created by 滕施男 on 15/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class ReminderListController: UITableViewController, addReminderDelegate, showReminderDetailDelegate {
    
    var currentReminderList: NSMutableArray
    
    //Generate a NSMutableArrary to store Reminder objects.
    required init?(coder aDecoder: NSCoder) {
        self.currentReminderList = NSMutableArray()
        super.init(coder: aDecoder)
    }
    
    /*
     Called when save button in the AddReminderController has been tapped.
     Put new Reminder object into currentReminderList.
     Sort data in the currentReminderList via dueDate.
     */
    func addReminder(reminder: Reminder) {
        self.currentReminderList.addObject(reminder)
        
        //Sort the table view cells
        currentReminderList.sortUsingComparator { (o1, o2) -> NSComparisonResult in
            (o2 as! Reminder).dueDate!.compare((o1 as! Reminder).dueDate!)
        }
        self.tableView.reloadData()
    }
    
    /*
     Called when switch in the DetailController has been used.
     Change object's isComplete state.
     Reload the table view.
     */
    func changeCompleteState (index: Int, reminder: Reminder) {
        self.currentReminderList.replaceObjectAtIndex(index, withObject: reminder)
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set rowHeight
        self.tableView.rowHeight = 60.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     There are two sections in the table view.
     One for showing Reminders.
     The other for showing how many Reminders.
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    /*
     Reture the value of number of rows in different sections.
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return self.currentReminderList.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    /*
     Configure cells in different sections.
     Demenstrate information in the currentReminderList using cells (first section).
     Show how many cells are there in the first section (This is second secion's job).
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let cellIdentifier = "ReminderCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReminderCell
            // Configure the cell...
            let r: Reminder = self.currentReminderList[indexPath.row] as! Reminder
            cell.titleLabel.text = r.title
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            cell.dueDateLabel.text = dateFormatter.stringFromDate(r.dueDate!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TotalCell", forIndexPath: indexPath)
            cell.textLabel!.text = "Total Reminders: \(currentReminderList.count)"
            return cell
        }
    }
    
    /*
     Prepare relative information before a segue is triggered.
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddReminderSegue" {
            let controller: AddReminderController = segue.destinationViewController as! AddReminderController
            controller.delegate = self
        }
        
        //Pass selected Reminder object and its Index in the Array to DetailController.
        if segue.identifier == "ShowReminderDetailSegue" {
            let controller: DetailController = segue.destinationViewController as! DetailController
            controller.delegate = self
            let r: Reminder = self.currentReminderList[(self.tableView.indexPathForSelectedRow?.row)!] as! Reminder
            let i: Int = (self.tableView.indexPathForSelectedRow?.row)!
            if let destinationVC = segue.destinationViewController as? DetailController{
                destinationVC.currentReminder = r
                destinationVC.currentIndex = i
            }
        }
    }

    /*
     Section one can be edited, but section two cannot be.
     */
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0{
            return true
        } else{
            return false
        }
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.currentReminderList.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let totalPath = NSIndexPath(forRow: 0, inSection: 1)
            tableView.reloadRowsAtIndexPaths([totalPath], withRowAnimation: .None)
        }
    }

}
