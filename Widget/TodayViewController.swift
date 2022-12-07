//
//  TodayViewController.swift
//  Widget
//
//  Created by Nirosha on 2022-11-26.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        
        let submissionName = UserDefaults.group.object(forKey: "name")
        let dueDate = UserDefaults.group.object(forKey: "date")
        
        name.text = ((submissionName as! String))
        date.text = ("Due Date: " + (dueDate as! String))
    
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        print("mode changed")
        
        preferredContentSize = maxSize
    }
    
}


extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.com.example.ExamBuddy")!
}
