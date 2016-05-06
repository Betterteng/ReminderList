//
//  Reminder.swift
//  ReminderList
//
//  Created by 滕施男 on 15/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class Reminder: NSObject {
    
    var title: String?
    var desc: String?
    var dueDate: NSDate?
    var isComplete: Bool?
    
    init(title: String, desc: String, dueDate: NSDate, isComplete: Bool) {
        self.title = title
        self.desc = desc
        self.dueDate = dueDate
        self.isComplete = false
    }
}
