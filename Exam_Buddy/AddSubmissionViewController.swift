//
//  AddSubmissionViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-22.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class AddSubmissionViewController: UIViewController {
    
    
    @IBOutlet weak var examName: UITextField!
    
    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var dueDate: UITextField!
    
     var assignmentArray=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func saveData () {
        
        
        let userDefault=UserDefaults.standard.integer(forKey: Constant.COUNT)
        
        let tenCount = userDefault + 1
        //var eachName = nameArray[indexOfTenant]
        
        
        UserDefaults.standard.set(examName.text, forKey: Constant.ASSIGNMENT_NAME+examName.text!)
        
        UserDefaults.standard.set(courseName.text!, forKey: Constant.COURSE_NAME+courseName.text!)
    
        UserDefaults.standard.set(type.text, forKey: Constant.TYPE+type.text!)
        
        UserDefaults.standard.set(dueDate.text, forKey: Constant.DUE_DATE+dueDate.text!)
        
        UserDefaults.standard.set(tenCount, forKey: Constant.COUNT)
        
        assignmentArray.append(examName.text!)
        
        
        print("name \(examName.text)")
        print("course \(courseName.text)")
        print("type \(type.text)")
        print("due date \(dueDate.text)")
        
    }
    
     // MARK: - Navigation
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier=="goToHome" {
                let destinationVC=segue.destination as! HomeTableViewController

                 saveData()
                
                 destinationVC.assignmentArray = assignmentArray
                
            }
        }
    
}


struct Constant {
    static let COUNT="count"
    static let ASSIGNMENT="assignment"
    static let ASSIGNMENT_NAME="assignmentName"
    static let COURSE_NAME="courseName"
    static let TYPE="TYPE"
    static let DUE_DATE="dueDate"
}
