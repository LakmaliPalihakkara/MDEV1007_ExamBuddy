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
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
      //  let submissionName = UserDefaults.standard.string(forKey: "name")
        
        let submissionName = UserDefaults.group.object(forKey: "name")
        let dueDate = UserDefaults.group.object(forKey: "date")
        
        name.text = ((submissionName as! String) + "\nDue Date: " + (dueDate as! String))
      //  date.text =dueDate as? Str ing
        
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
