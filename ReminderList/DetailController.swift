//
//  DetailController.swift
//  ReminderList
//
//  Created by 滕施男 on 16/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

protocol showReminderDetailDelegate {
    func changeCompleteState(index: Int, reminder: Reminder)
}

class DetailController: UIViewController {
    
    var delegate: showReminderDetailDelegate?

    @IBOutlet var titleL: UILabel!
    @IBOutlet var descL: UILabel!
    @IBOutlet var dueDateL: UILabel!
    @IBOutlet var isCompleteL: UILabel!
    @IBOutlet var switchS: UISwitch!
    
    var currentReminder: Reminder?
    var currentIndex: Int?
    
    //When view is loaded, refresh relative labels in the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleL.text = currentReminder?.title
        descL.text = currentReminder?.desc
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dueDateL.text = dateFormatter.stringFromDate(currentReminder!.dueDate!)
        
        changeIsCompleteLabel()
    }

    /*
     When switch's value changed, change currenReminder's isComplete value, then pass it back
     to ReminderListController and change isComplete state.
     Refresh isComplete label.
     */
    @IBAction func switchSeleted(sender: UISwitch) {
        currentReminder?.isComplete = switchS.on
        self.delegate?.changeCompleteState(currentIndex!, reminder: currentReminder!)
        changeIsCompleteLabel()
    }
    
    /*
     Change isComplete Label's value according to the status of switch.
     */
    func changeIsCompleteLabel() {
        if (currentReminder?.isComplete == false) {
            switchS.setOn(false, animated: true)
            isCompleteL.text = "Uncomplete"
        } else {
            switchS.setOn(true, animated: true)
            isCompleteL.text = "Complete"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
