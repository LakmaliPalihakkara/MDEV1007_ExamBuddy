//
//  HomeViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-08.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeTableViewCellDelegate{
    func didTapButton(with title: String) {
        print ("didTapButton \(title)")
    }
    
    
    @IBOutlet weak var tblUpcoming: UITableView!
    
    @IBOutlet weak var tblToday: UITableView!
    
    @IBOutlet weak var tblCompleted: UITableView!
    
    
    
    var todayArray:[SubmissionObject]=[]
    var upComingArray:[SubmissionObject]=[]
    var completedArray:[SubmissionObject]=[]
    
    let notificationGenerator = NotificationGenerator()
    
    let userDefaults = UserDefaults.standard
    
    var upComingArr : SubmissionObject?
    var completedArr : SubmissionObject?
    
    
    var index : Int = 0
    
    @IBOutlet weak var username: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableStyle()
        
        let decoder = JSONDecoder()
        let userData = UserDefaults.standard.data(forKey: "user")
        if let user = try? decoder.decode(UserObject.self, from: userData!) {
            username.text = user.username
        }
        
        
        
        
        let data = UserDefaults.standard.data(forKey: "submissionAdd")
        let dataUpdate = UserDefaults.standard.data(forKey: "submissionUpdate")
        do {
            
            let decoder = JSONDecoder()
            
            
            if(data != nil)
            {
                upComingArr = try decoder.decode(SubmissionObject.self, from: data!)
                
                
                
            }
            
            if(dataUpdate != nil)
            {
                completedArr = try decoder.decode(SubmissionObject.self, from: dataUpdate!)
                
            }
            
        } catch {
            print("Unable to Decode Note (\(error))")
        }
        
        
        
        if(todayArray.count != 0)
        {
            
            
            tblToday.dataSource = self
        }
        
        print("upComingArr?.exam  (\(String(describing: upComingArr?.exam) ))")
        if (upComingArr?.exam  != nil)
        {
            tblUpcoming.dataSource = self
        }
        
        print("completedArr?.exam  (\(String(describing: completedArray.count) ))")
        
        if (completedArray.count != 0)
        {
            tblCompleted.dataSource = self
        }
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == self.tblToday)
        {
            return todayArray.count
        }
        
        
        if(tableView == self.tblUpcoming)
        {
            
            return upComingArray.count
        }
        
        print("upComingArray.count   (\(String(describing: completedArray.count ) ))")
        
        
        
        if(tableView == self.tblCompleted)
        {
            
            return completedArray.count
        }
        
        return 0
    }
    
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if(tableView == self.tblToday)
            
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellForInfoTable", for: indexPath)as! HomeTableViewCell
            
            
            cell.contentView.backgroundColor = UIColor.clear
            
            
            
            cell.assignmentName.text = todayArray[indexPath.row].exam
            cell.courseName.text = todayArray[indexPath.row].course
            cell.dueDate.text = todayArray[indexPath.row].date
            
            return cell
        }
        
        
        
        if(tableView == self.tblUpcoming)
        {
            let cellUpcoming = tableView.dequeueReusableCell(withIdentifier: "cellForUpcomingTable", for: indexPath)as! UpcomingTableViewCell
            print ("cellForRowAt")
            
            
            cellUpcoming.name.text = upComingArray[indexPath.row].exam
            cellUpcoming.courseName.text = upComingArray[indexPath.row].course
            cellUpcoming.type.text = upComingArray[indexPath.row].date
            
            
            
            cellUpcoming.delegateUpcoming = self
            
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey:"index")
            
            cellUpcoming.btnView.tag = indexPath.row
            cellUpcoming.btnView.addTarget(self, action: #selector(buttonClickMethod(_:)), for: .touchUpInside)
            
            
            
            
            return cellUpcoming
        }
        
        print("completedArr?.examTable (\(String(describing: completedArray.count)))")
        
        
        if(tableView == self.tblCompleted)
        {
            let cellCompleted = tableView.dequeueReusableCell(withIdentifier: "cellCompleted", for: indexPath)as! CompletedTableTableViewCell
            print ("cellCompleted")
            
            
            cellCompleted.name.text = completedArray[indexPath.row].exam
            cellCompleted.course.text = completedArray[indexPath.row].course
            cellCompleted.date.text = completedArray[indexPath.row].date
            
            
            cellCompleted.delegateCompleted = self
            return cellCompleted
        }
        
        
        return UITableViewCell()
        
        
    }
    
    
    @objc func buttonClickMethod(_ sender: UIButton){
        
        
        print("buttonNumber (\(index))")
        
        
        
        index = sender.tag
        
        
        
        
        UserDefaults.standard.set(index, forKey: "index")
    }
    
    
    
    func getCurrentDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        
        return dateString
    }
    
    
    func tableStyle(){
        
        tblToday.backgroundColor = UIColor.clear
        tblToday.layer.borderColor = UIColor.gray.cgColor
        tblToday.layer.borderWidth = 1.0
        
        tblUpcoming.backgroundColor = UIColor.clear
        tblUpcoming.layer.borderColor = UIColor.gray.cgColor
        tblUpcoming.layer.borderWidth = 1.0
        
        tblCompleted.backgroundColor = UIColor.clear
        tblCompleted.layer.borderColor = UIColor.gray.cgColor
        tblCompleted.layer.borderWidth = 1.0
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        print(cell.textLabel?.text! as Any)
        
        print ("didSelectRowAt \(indexPath.row)")
    }
    
    
    @IBAction func notificationBtn(_ sender: Any) {
        
        NotificationGenerator.generateNotification(title: "Reminder", description: "submission")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="goToAdd" {
            let destinationVC=segue.destination as! AddSubmissionViewController
            
            destinationVC.todayArray = todayArray
            destinationVC.upcomingArray1 = upComingArray
            destinationVC.updateArray = completedArray
            
            
            
            
        }
        
        if segue.identifier=="goToUpdate" {
            
            let destinationVC=segue.destination as! UpdateSubmissionViewController
            
            
            destinationVC.todayArray = todayArray
            destinationVC.upComingArray1 = upComingArray
            destinationVC.updateArray = completedArray
            
            
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete{
            
            if(tableView == self.tblToday)
            {
                todayArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if(tableView == self.tblUpcoming)
            {
                upComingArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if(tableView == self.tblCompleted)
            {
                completedArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            
            UserDefaults.standard.removeObject(forKey:"index")
            do {
                let encodeData = try JSONEncoder().encode(upComingArr)
                UserDefaults.standard.set(encodeData, forKey: "submissionAdd")
                // synchronize is not needed
            } catch { print(error) }
        }
    }
    
    
    
    
}


extension ViewController : HomeTableViewCellDelegate {
    
    func didTapButton(with title: String) {
        print ("didTapButton \(title)")
    }
}

