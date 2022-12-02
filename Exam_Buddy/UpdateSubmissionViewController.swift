//
//  UpdateSubmissionViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-28.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class UpdateSubmissionViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var examName: UITextField!
    
    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var dueDate: UITextField!
    

    // var assignmentArray=[String]()
    
    @IBOutlet weak var btnUpdate: UIButton!
    

    
     var todayArray=[String]()
       var upcomingArray=[String]()
       
         let datePicker = UIDatePicker()
       
           let userDefaults = UserDefaults.standard
       
       override func viewDidLoad() {
           super.viewDidLoad()

   //        let datePicker = UIDatePicker()
   //        datePicker.datePickerMode = .date
   //        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
   //        datePicker.frame.size = CGSize(width: 0, height: 250)
   //        datePicker.preferredDatePickerStyle = .wheels
   //
   //        dueDate.inputView = datePicker
           
         //  if(examName.text  != ""){
           
         //  setTextStyle()
           
           
           
           examName.delegate = self
           
           examName.text = UserDefaults.standard.string(forKey: Constant.ASSIGNMENT_NAME)
         //  }
           
           createDatePicker()
       }
       

       func saveData () {
           
           
           let userDefault=UserDefaults.standard.integer(forKey: UpdateConstant.COUNT)

           let tenCount = userDefault + 1
           //var eachName = nameArray[indexOfTenant]


           UserDefaults.standard.set(examName.text, forKey: UpdateConstant.ASSIGNMENT_NAME)

           UserDefaults.standard.set(courseName.text!, forKey: UpdateConstant.COURSE_NAME+courseName.text!)

           UserDefaults.standard.set(type.text, forKey: UpdateConstant.TYPE+type.text!)

           UserDefaults.standard.set(dueDate.text, forKey: UpdateConstant.DUE_DATE+dueDate.text!)

           UserDefaults.standard.set(tenCount, forKey: UpdateConstant.COUNT)
   //
   //        assignmentArray.append(examName.text!)
   //
            let returnValue: [String]? = UserDefaults.standard.object(forKey: UpdateConstant.ASSIGNMENT_NAME) as? [String]
   //
           print ("UserDefaults\(String(describing: returnValue))")
           
       
          
           
        
           
           
         if(dueDate.text == getCurrentDate() )
         {
            todayArray.append(examName.text!)
            userDefaults.set(todayArray, forKey: "todayArr")

         }
       
           if(dueDate.text ?? "" > getCurrentDate() ){
             
            print ("remove")
           //  upcomingArray.remove(at: 0)
             upcomingArray.append(examName.text!)
             userDefaults.set(upcomingArray, forKey: "upComingArr")
             
         }
           
           UpdateConstant.duedatesave = dueDate.text ?? ""
           
          
           
       }
       
        // MARK: - Navigation
       
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               
               if segue.identifier=="goToHome" {
                   let destinationVC=segue.destination as! HomeViewController

                 
                   
                //   var view = UserDefaults.standard.bool(forKey: UpdateConstant.VIEW)
                   
                   
                   
                 
                   
   //                let formatter = DateFormatter()
   //
   //                formatter.dateFormat = "MMM dd, yyyy"
   //                let now = Date()
   //                let dateString = formatter.string(from:now)
   //
   //                print ("dueDate.text \(String(describing: dueDate.text))")
   //                print ("dateString \(dateString)")
                   
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
                    
                       destinationVC.todayArray = todayArray
                   
                   }
                   
                   if(dueDate.text ?? "" > getCurrentDate() ){
                       
                        print ("AddSubmission")
                     //  destinationVC.upComingArray = upcomingArray
                   }
                   
               }
            
            if segue.identifier=="goToHomeUpdate" {
                 let destinationVC=segue.destination as! HomeViewController
                
               
               // userDefaults.removeSuite(named: "upComingArr")
                
                saveData()
                
                // userDefaults.set(upcomingArray, forKey: "upComingArr")
               //  destinationVC.upComingArray = upcomingArray
              
               
            }
           }
       
   //
   //    @objc func dateChange(datePicker: UIDatePicker)
   //    {
   //        dueDate.text = formatDate(date: datePicker.date)
   //    }
   //
   //    func formatDate(date: Date) -> String{
   //        let formatter = DateFormatter()
   //        formatter.dateFormat = "MMM dd yyyy"
   //        return formatter.string(from: date)
   //    }
       
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
           
   //        if #available(iOS 13.4, *) {Thread()
   //           datePicker.preferredDatePickerStyle = .wheels
   //
   //
   //        }
   //
           dueDate.inputAccessoryView = toolbar
                       
           dueDate.inputView = datePicker
                       
           datePicker.datePickerMode = .date
         
       }
       
       
       @objc func donePressed(){
              
              let formatter = DateFormatter()
              formatter.dateFormat = "MMM dd, yyyy"
             // let selectedDate = formatter.string(from: datePicker.date)
   //           formatter.dateStyle = .medium
   //           formatter.timeStyle = .none
              
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
           
//           btnSave.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
//           btnSave.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
//           btnSave.layer.cornerRadius = 10;
       }



          
   }


   struct UpdateConstant {
       static let COUNT="count"
       static let ASSIGNMENT="assignment"
       static let ASSIGNMENT_NAME="assignmentName"
       static let COURSE_NAME="courseName"
       static let TYPE="TYPE"
       static let DUE_DATE="dueDate"
       
       static var duedatesave = ""
   }

