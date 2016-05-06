//
//  AddReminderController.swift
//  ReminderList
//
//  Created by 滕施男 on 15/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

protocol addReminderDelegate {
    func addReminder(reminder: Reminder)
}

class AddReminderController: UIViewController {
    
    var delegate: addReminderDelegate?

    @IBOutlet var titleT: UITextField!
    @IBOutlet var descT: UITextField!
    @IBOutlet var dueDateT: UITextField!
    
    /*
     When save button selected, the method will be called.
     Gather information from text fields and generate a Reminder object, then put the object into MutableArray
     in the ReminderListController (via addReminderDelegate protocol => addReminder method). This method will
     also validate user's input.
     */
    @IBAction func selectSaveBtn(sender: UIButton) {
        let currTitle = titleT.text
        let currDesc = descT.text
        let dueDateString = dueDateT.text!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currDueDate: NSDate? = dateFormatter.dateFromString(dueDateString)
        
        if (currTitle?.characters.count == 0 || currDesc!.characters.count == 0 || dueDateString.characters.count == 0) {
            let alert = UIAlertController(title: "Sorry", message: "Not all blanks are filled in", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        if (currDueDate == nil) {
            let alert = UIAlertController(title: "Sorry", message: "Invalid due date input", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let r: Reminder = Reminder(title: currTitle!, desc: currDesc!, dueDate: currDueDate!, isComplete: false)
        self.delegate?.addReminder(r)
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddReminderController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized to dismiss the keyboard.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
