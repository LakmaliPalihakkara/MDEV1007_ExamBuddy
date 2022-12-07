//
//  UpdateSubmissionViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-28.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class UpdateSubmissionViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var examName: UITextField!
    
    @IBOutlet weak var courseName: UITextField!
    
    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var dueDate: UITextField!
    
    
    // var assignmentArray=[String]()
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBOutlet weak var tblType: UITableView!
    
    @IBOutlet weak var tblDropDownHC: NSLayoutConstraint!
    
    @IBOutlet weak var btnType: UIButton!
    
    var todayArray=[SubmissionObject]()
    var updateArray=[SubmissionObject]()
    var upComingArray1=[SubmissionObject]()
    
    var list = ["Exam", "Assignment"]
    var isTableVisible = false
    
    var upcomingArray=[String]()
    
    let datePicker = UIDatePicker()
    
    let userDefaults = UserDefaults.standard
    
    var index : Int = 0
    
    var updateArr : SubmissionObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tblType.delegate = self
        tblType.dataSource = self
        tblDropDownHC.constant = 0
        
        setTextStyle()
        
        index = userDefaults.integer(forKey: "index")
        
        
        examName.text = upComingArray1[index].exam
        courseName.text = upComingArray1[index].course
        dueDate.text = upComingArray1[index].date
        btnType.setTitle(upComingArray1[index].type, for: .normal)
        
        createDatePicker()
    }
    
    
    
    @IBAction func onClickDoneBtn(_ sender: Any) {
        
        
        let dialogMessage = UIAlertController(title: "Confirm", message: "Did you submit the " + examName.text! + "?", preferredStyle: .alert)
        
        
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Ok button click...")
            self.checkDone()
        })
        
        
        let cancel = UIAlertAction(title: "No", style: .cancel) { (action) -> Void in
            print("Cancel button click...")
        }
        
        
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func checkDone()
    {
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "welldone") as! WellDoneViewController
        self.present(balanceViewController, animated: true, completion: nil)
        
        saveData()
        
        upComingArray1.remove(at: index)
        balanceViewController.completedArray = updateArray
        balanceViewController.upComingArray = upComingArray1
        
    }
    
    
    func saveData () {
        
        
        let submission1 = SubmissionObject(exam: examName.text!, course: courseName.text!, type: btnType.currentTitle!, date: dueDate.text!, done: true)
        updateArray.append(submission1)
        
        
        
        
        do {
            
            let encoder = JSONEncoder()
            
            
            let data = try encoder.encode(submission1)
            
            
            UserDefaults.standard.set(data, forKey: "submissionAdd")
            
        } catch {
            print("Unable to Encode Note (\(error))")
        }
        
        
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="goToUpdate" {
            let destinationVC=segue.destination as! HomeViewController
            
            
            
            
            saveData()
            
            
            
          //  destinationVC.completedArray = updateArray
            destinationVC.upComingArray = updateArray
            destinationVC.todayArray = todayArray
            //destinationVC.index = index
            
            
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
        
        btnUpdate.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        btnUpdate.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        btnUpdate.layer.cornerRadius = 10;
    }
    
    
    
    @IBAction func onClickType(_ sender: Any) {
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
