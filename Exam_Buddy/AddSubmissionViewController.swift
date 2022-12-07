//
//  AddSubmissionViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-22.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class AddSubmissionViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var examName: UITextField!
    
    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var dueDate: UITextField!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBOutlet weak var tblType: UITableView!
    
    @IBOutlet weak var btnType: UIButton!
    
    
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    
    var submissionObject = [SubmissionObject]()
    
    
    
    //  var todayArray=[String]()
    var upcomingArray=[String]()
    var upcomingArray1=[SubmissionObject]()
    var updateArray=[SubmissionObject]()
    var todayArray=[SubmissionObject]()
    
    let datePicker = UIDatePicker()
    
    let userDefaults = UserDefaults.standard
    
    var isTableVisible = false
    
    var list = ["Exam", "Assignment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblType.delegate = self
        tblType.dataSource = self
        tblDropDownHC.constant = 0
        
        
        createDatePicker()
        
        
    }
    
    
    func saveData () {
        
        //
        //        let userDefault=UserDefaults.standard.integer(forKey: Constant.COUNT)
        //
        //        let tenCount = userDefault + 1
        //
        //
        //        UserDefaults.standard.set(examName.text, forKey: Constant.ASSIGNMENT_NAME)
        //
        //        UserDefaults.standard.set(courseName.text!, forKey: Constant.COURSE_NAME+courseName.text!)
        //
        //        UserDefaults.standard.set(type.text, forKey: Constant.TYPE+type.text!)
        //
        //        UserDefaults.standard.set(dueDate.text, forKey: Constant.DUE_DATE+dueDate.text!)
        //
        //        UserDefaults.standard.set(tenCount, forKey: Constant.COUNT)
        //
        //        let returnValue: [String]? = UserDefaults.standard.object(forKey: Constant.ASSIGNMENT_NAME) as? [String]
        //
        //        print ("UserDefaults\(String(describing: returnValue))")
        //
        
        
        
        
        
        
//        if(dueDate.text == getCurrentDate() )
//        {
//            todayArray.append(examName.text!)
//            userDefaults.set(todayArray, forKey: "todayArr")
//
//        }
        
       // if(dueDate.text ?? "" > getCurrentDate() ){
            
            
        let submission1 = SubmissionObject(exam: examName.text!, course: courseName.text!, type: btnType.currentTitle!, date: dueDate.text!, done: false)
            
      //  print("btntype (\(String(describing: btnType.titleLabel?.text)))")
     
            if(dueDate.text! == getCurrentDate())
            {
                todayArray.append(submission1)
//                UserDefaults.standard.set(todayArray[0].exam, forKey: "name")
//                UserDefaults.standard.set(todayArray[0].date, forKey: "date")
                
             //  UserDefaults(suiteName: "group.com.example.ExamBuddy")!.set(todayArray[0].exam, forKey: "name")
               
                UserDefaults.group.set(todayArray[0].exam, forKey: "name")
                UserDefaults.group.set(todayArray[0].date, forKey: "date")
                
                NotificationGenerator.generateNotification(title: "Reminder", description: todayArray[0].exam + "\nDue date:" + todayArray[0].date )

            }
            
            if(dueDate.text! > getCurrentDate()) {
                upcomingArray1.append(submission1)
            }
            
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()
                
                // Encode Note
                let data = try encoder.encode(submission1)
                
                // Write/Set Data
                UserDefaults.standard.set(data, forKey: "submissionAdd")
                
            } catch {
                print("Unable to Encode Note (\(error))")
            }
            
         //   UserDefaults.standard.set(upcomingArray1[0].exam, forKey: "exam")
     //   }
        
        //  Constant.duedatesave = dueDate.text ?? ""
        
        
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="goToHome" {
            let destinationVC=segue.destination as! HomeViewController
            
            
            saveData()
            
            if(dueDate.text == getCurrentDate() )
            {
                //print ("todayArray \(dateString)")
                
                //                    if(view){
                //
                //                        UserDefaults.standard.removeObject(forKey: Constant.ASSIGNMENT_NAME)
                //
                //
                //                        todayArray.removeAll()
                
                
                
                //                         destinationVC.todayArray = todayArray
                //                    }
                //                    else
                //                    {
                //                        saveData()
                //
                //                         destinationVC.todayArray = todayArray
                //                    }
                //
                
                //destinationVC.todayArray = todayArray
                destinationVC.todayArray = todayArray
                
            }
            
            if(dueDate.text ?? "" > getCurrentDate() ){
                
                print ("AddSubmission")
                //  destinationVC.upComingArray = upcomingArray
                destinationVC.upComingArray = upcomingArray1
                destinationVC.completedArray = updateArray
                destinationVC.todayArray = todayArray
                
            }
            
        }
    }
    
    
    func getCurrentDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        
        return dateString
    }
    
    
    func createDatePicker(){
        
        datePicker.minimumDate = Date()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        datePicker.frame.size = CGSize(width: 0, height: 250)
        
        
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        dueDate.inputAccessoryView = toolbar
        
        dueDate.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    
    
    @objc func donePressed(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        dueDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    func setTextStyle(){
        
        
        self.examName.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        examName.layer.cornerRadius = 15.0
        examName.clipsToBounds = true
        examName.layer.borderWidth = 2.0
        
        
        self.courseName.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        courseName.layer.cornerRadius = 15.0
        courseName.clipsToBounds = true
        courseName.layer.borderWidth = 2.0
        
        
        self.type.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        type.layer.cornerRadius = 15.0
        type.clipsToBounds = true
        type.layer.borderWidth = 2.0
        
        self.dueDate.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        dueDate.layer.cornerRadius = 15.0
        dueDate.clipsToBounds = true
        dueDate.layer.borderWidth = 2.0
        
        btnSave.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        btnSave.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        btnSave.layer.cornerRadius = 10;
    }
    
    @IBAction func typeDisplay(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            if self.isTableVisible == false{
                self.isTableVisible = true
                self.tblDropDownHC.constant = 34.0 * 3.0
            } else
            {
                self.tblDropDownHC.constant = 0
                self.isTableVisible = false
            }
            self.view.layoutIfNeeded()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblType
        {
            return list.count
        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "type")
        
        if tableView == tblType {
            
            if cell == nil{
                cell == UITableViewCell(style: .default, reuseIdentifier: "type")
            }
            //cell?.textLabel?.text = "\(indexPath.row + 1) rooms"
            
            cell?.textLabel?.text = list[indexPath.row]
            
            return cell!
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        btnType.setTitle((list[indexPath.row]), for: .normal)
        
        UIView.animate(withDuration: 0.5) {
            
            self.tblDropDownHC.constant = 0
            self.isTableVisible = false
            self.view.layoutIfNeeded()
            
        }
    }
    
    
    
    
}

extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.com.example.ExamBuddy")!
}

//struct Constant {
//    static let COUNT="count"
//    static let ASSIGNMENT="assignment"
//    static let ASSIGNMENT_NAME="assignmentName"
//    static let COURSE_NAME="courseName"
//    static let TYPE="TYPE"
//    static let DUE_DATE="dueDate"
//
//    static var duedatesave = ""
//}





