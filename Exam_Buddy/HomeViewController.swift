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
    
    
    var todayArray:[String]=[]
    
    var upComingArray:[SubmissionObject]=[]
    
    let notificationGenerator = NotificationGenerator()
    
    let userDefaults = UserDefaults.standard
    
    var upComingArr : SubmissionObject?
    
  //   var note : SubmissionObject?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationGenerator.generateNotification(title: "Reminder", description: "submission")

        
        tblToday.backgroundColor = UIColor.clear
        tblToday.layer.borderColor = UIColor.gray.cgColor
        tblToday.layer.borderWidth = 1.0
        
        tblUpcoming.backgroundColor = UIColor.clear
        tblUpcoming.layer.borderColor = UIColor.gray.cgColor
        tblUpcoming.layer.borderWidth = 1.0
 
        
        let stringArray = userDefaults.stringArray(forKey: "todayArr") ?? [String]()
        
    
        todayArray = stringArray
        
        let data = UserDefaults.standard.data(forKey: "submissionAdd")
           do {
               // Create JSON Decoder
               let decoder = JSONDecoder()

               // Decode Note
            
            if(data != nil)
            {
                upComingArr = try decoder.decode(SubmissionObject.self, from: data!)
                
            }

           } catch {
               print("Unable to Decode Note (\(error))")
           }
        
        
        
        if(Constant.duedatesave == getCurrentDate() || todayArray.count != 0)
         {
        

        tblToday.dataSource = self
        }
        
        print("upComingArr?.exam  (\(String(describing: upComingArr?.exam) ))")
        if (upComingArr?.exam  != nil)
         {
        tblUpcoming.dataSource = self
        }

    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
          
        return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(Constant.duedatesave == getCurrentDate() || todayArray.count != 0)
        {
           return todayArray.count
        }
        
        
        if (Constant.duedatesave > getCurrentDate() || upComingArray.count != 0)
        {
              
            return upComingArray.count
        }
        
         return 0
       }

       
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if(Constant.duedatesave == getCurrentDate() || todayArray.count != 0)
      //  if(tableView == tblToday)
        {
          
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifer, for: indexPath)as! HomeTableViewCell
            
           
                   cell.contentView.backgroundColor = UIColor.clear
            
            cell.configure(with: todayArray[indexPath.row])
            
           
       
            cell.assignmentName.text = todayArray[indexPath.row]
            cell.delegate = self
              return cell
        }
        
        if (upComingArr?.exam != nil)
        // if(tableView == tblUpcoming)
        {
              let cellUpcoming = tableView.dequeueReusableCell(withIdentifier: "cellForUpcomingTable", for: indexPath)as! UpcomingTableViewCell
              print ("cellForRowAt")

            
           // cellUpcoming.name.text = upComingArr?.exam
             cellUpcoming.name.text = upComingArray[indexPath.row].exam
         //   cellUpcoming.courseName.text = upComingArray[indexPath.row].course
             cellUpcoming.courseName.text = upComingArray[indexPath.row].course
            cellUpcoming.type.text = upComingArray[indexPath.row].date
            
            
             cellUpcoming.delegateUpcoming = self
            return cellUpcoming
        }
        
        
        return UITableViewCell()
        
        
    }
        
       
    
    func getCurrentDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        
        return dateString
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
            
        //    destinationVC.upcomingArray1 = upComingArray
           
            
            
        }
        
        if segue.identifier=="goToUpdate" {
            
            let viewButton = sender as! UIButton
            let destinationVC=segue.destination as! UpdateSubmissionViewController
            
       
            destinationVC.todayArray = todayArray
        
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete{
            upComingArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // userDefaults.set(upComingArray, forKey: "upComingArr")
            
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

