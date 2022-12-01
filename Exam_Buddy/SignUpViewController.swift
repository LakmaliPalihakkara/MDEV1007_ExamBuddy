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
        
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            
            setTextStyle()
                      
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
    
    func setTextStyle(){
        

        self.textFieldUsername.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        textFieldUsername.layer.cornerRadius = 15.0
        textFieldUsername.clipsToBounds = true
        textFieldUsername.layer.borderWidth = 2.0
        
        
        self.textFieldEmail.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        textFieldEmail.layer.cornerRadius = 15.0
        textFieldEmail.clipsToBounds = true
        textFieldEmail.layer.borderWidth = 2.0
        
        
        self.textFieldPassword.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        textFieldPassword.layer.cornerRadius = 15.0
        textFieldPassword.clipsToBounds = true
        textFieldPassword.layer.borderWidth = 2.0
        
        self.textFieldConfirmPassword.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        textFieldConfirmPassword.layer.cornerRadius = 15.0
        textFieldConfirmPassword.clipsToBounds = true
        textFieldConfirmPassword.layer.borderWidth = 2.0
        
        btnSignup.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        btnSignup.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        btnSignup.layer.cornerRadius = 10;
    }

    }

