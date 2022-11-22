//
//  LocalStorageManager.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-08.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import Foundation

class LocalStorageManager{

 static var getAllObjects: [UserObject] {
          let defaultObject = UserObject()
          if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
             let decoder = JSONDecoder()
             if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [UserObject] {
                return objectsDecoded
             } else {
                return [defaultObject]
             }
          } else {
             return [defaultObject]
          }
       }

     static func saveAllObjects(allObjects: [UserObject]) {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(allObjects){
             UserDefaults.standard.set(encoded, forKey: "user_objects")
          }
     }
    
    
    static var getSubmissionObjects: [UserObject] {
         let defaultObject = UserObject()
         if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [UserObject] {
               return objectsDecoded
            } else {
               return [defaultObject]
            }
         } else {
            return [defaultObject]
         }
      }

    static func submissionObjects(allObjects: [UserObject]) {
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(allObjects){
            UserDefaults.standard.set(encoded, forKey: "user_objects")
         }
    }
}

