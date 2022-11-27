//
//  HomeViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-08.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var tblToday: UITableView!
    @IBOutlet weak var tblUpcoming: UITableView!
    
      var todayArray:[String]=[]
      var upComingArray:[String]=[]
    
    let notificationGenerator = NotificationGenerator()
    
        let userDefaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let todayArr = userDefaults.object(forKey: "todayArr")
//        print ("UserDefaults\(String(describing: todayArr))")
        
        let stringArray = userDefaults.stringArray(forKey: "todayArr") ?? [String]()
        let upcomingArr = userDefaults.stringArray(forKey: "upComingArr") ?? [String]()
        
         
       // print ("stringArray\(String(describing: stringArray))")
        todayArray = stringArray
        upComingArray = upcomingArr
        
        
        
        if(Constant.duedatesave == getCurrentDate() || todayArray.count != 0)
         {
        tblToday.dataSource = self
        }
        
        
        if (Constant.duedatesave > getCurrentDate() || upComingArray.count != 0)
         {
        tblUpcoming.dataSource = self
        }

        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
        return 1
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
        
//        print ("HOmedueDate.text \(String(describing: AddSubmissionViewController().dueDate.text))")
//        print ("HOmedateString \(getCurrentDate())")
        
        print ("diffrence \(Constant.duedatesave > getCurrentDate())")
         print ("Constant.duedatesave \(Constant.duedatesave)")
         print ("getCurrentDate \(getCurrentDate())")
        
        if(Constant.duedatesave == getCurrentDate() || todayArray.count != 0)
        {
           return todayArray.count
        }
        
        
        if (Constant.duedatesave > getCurrentDate() || upComingArray.count != 0)
        {
            print ("numberOfRowsInSection")
            return upComingArray.count
        }
        
         return 0
       }

       
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
        
//
//       let cellnull = tableView.dequeueReusableCell(withIdentifier: "cellForInfoTable", for: indexPath)as! HomeTableViewCell
         

        if(Constant.duedatesave == getCurrentDate() || todayArray.count != 0)
      //  if(tableView == tblToday)
        {
            print ("CellgetCurrentDate")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellForInfoTable", for: indexPath)as! HomeTableViewCell
            
           
       
            cell.assignmentName.text = todayArray[indexPath.row]
              return cell
        }
        
        if (Constant.duedatesave > getCurrentDate()  ||  upComingArray.count != 0)
        // if(tableView == tblUpcoming)
        {
              let cellUpcoming = tableView.dequeueReusableCell(withIdentifier: "cellForUpcomingTable", for: indexPath)as! UpcomingTableViewCell
              print ("cellForRowAt")
             cellUpcoming.name.text = upComingArray[indexPath.row]
            return cellUpcoming
        }
        
        
        return UITableViewCell()
        
        
    }
          

          // cell.viewButton.tag = indexPath.item

       // return cell
        
       
    
    func getCurrentDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        
        return dateString
    }
       
    @IBAction func notificationBtn(_ sender: Any) {
        
        NotificationGenerator.generateNotification(title: "Reminder", description: "submission")
    }
}
