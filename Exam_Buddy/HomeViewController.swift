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
    
      var todayArray:[String]=[]
      var upComingArray:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblToday.delegate = self
        tblToday.dataSource = self

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
           return todayArray.count
       }

       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellForInfoTable", for: indexPath)as! HomeTableViewCell


           cell.assignmentName.text = todayArray[indexPath.row]

          // cell.viewButton.tag = indexPath.item

           return cell
        
       }
       
}
