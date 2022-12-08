//
//  NotificationGenerator.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-26.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationGenerator{
    static func generateNotification(title : String, description : String)
    {
        requestAuthorization()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = description
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
       
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
        {
            (error) in
            if error != nil{
                
            }
        }
    }
    
    
    static func requestAuthorization(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]){
            granted, error in
            
            if let error = error {
                print ("Error requesting authorization \(error)")
            }
        }
    }
}


