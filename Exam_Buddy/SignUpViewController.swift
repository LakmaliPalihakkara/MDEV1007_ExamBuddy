//
//  SignUpViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-08.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

     
        @IBOutlet weak var textFieldUsername: UITextField!
        
        @IBOutlet weak var textFieldEmail: UITextField!
        
        @IBOutlet weak var textFieldPassword: UITextField!
        
        @IBOutlet weak var textFieldConfirmPassword: UITextField!
        
        let userObj: UserObject = UserObject()
        var filterData : [String] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
        }
        

        @IBAction func btnSignUp(_ sender: Any) {
            
            
            let userObj = UserObject(username: textFieldUsername.text!, email: textFieldEmail.text!, password: textFieldPassword.text!)
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(userObj) {
                UserDefaults.standard.set(encoded, forKey: "user")
            }
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
            self.present(balanceViewController, animated: true, completion: nil)
            
        }

    }

