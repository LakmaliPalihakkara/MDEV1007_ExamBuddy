//
//  ViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-08.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    let userObj: UserObject = UserObject()
    
    let userData = UserDefaults.standard.data(forKey: "user")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextStyle()
        
        
    }
    
    
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let decoder = JSONDecoder()
        
        if( emailTextField.text == "")
        {
            
            emailTextField.text = ""
            
            emailTextField.attributedPlaceholder = NSAttributedString(
                string: "Please enter your email",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
            
        else if( passwordTextField.text == "")
        {
            
            passwordTextField.text = ""
            
            passwordTextField.attributedPlaceholder = NSAttributedString(
                string: "Please enter your password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
            
        else if(userData == nil)
        {
            
            emailTextField.text = ""
            
            emailTextField.attributedPlaceholder = NSAttributedString(
                string: "No email found",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
            passwordTextField.text = ""
            
            passwordTextField.attributedPlaceholder = NSAttributedString(
                string: "No password found",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
        else if
            let user = try? decoder.decode(UserObject.self, from: userData!) {
            
            
            
            
            
            if(user.email != emailTextField.text)
            {
                emailTextField.text = ""
                
                emailTextField.attributedPlaceholder = NSAttributedString(
                    string: "Please enter correct email",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
                )
                
            }
            else if(user.password != passwordTextField.text)
            {
                passwordTextField.text = ""
                
                passwordTextField.attributedPlaceholder = NSAttributedString(
                    string: "Please enter correct password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
                )
            }
            else
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
                self.present(balanceViewController, animated: true, completion: nil)
            }
            
            
            
        }
    }
    
    
    func setTextStyle(){
        
        self.emailTextField.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        emailTextField.layer.cornerRadius = 15.0
        emailTextField.clipsToBounds = true
        emailTextField.layer.borderWidth = 2.0
        
        
        self.passwordTextField.layer.borderColor = UIColor(red:119/255, green:212/255, blue:252/255, alpha: 1).cgColor
        passwordTextField.layer.cornerRadius = 15.0
        passwordTextField.clipsToBounds = true
        passwordTextField.layer.borderWidth = 2.0
        
        loginBtn.widthAnchor.constraint(equalToConstant: 130.0).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        loginBtn.layer.cornerRadius = 10;
        
        
        
    }
    
    
}



extension CALayer {
    
    func addRadius(_ corners: UIRectCorner, radius: CGFloat, view: UIView) {
        let mask = CAShapeLayer()
        mask.bounds = view.frame
        mask.position = view.center
        mask.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        view.layer.mask = mask
    }
    
    func addRadius(radius: CGFloat) {
        self.cornerRadius = radius
    }
}


extension UserDefaults {
    
    func save<T: Codable>(_ object: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encodedObject = try? encoder.encode(object) {
            UserDefaults.standard.set(encodedObject, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getObject<T: Codable>(forKey key: String) -> T? {
        if let object = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let decodedObject = try? decoder.decode(T.self, from: object) {
                return decodedObject
            }
        }
        return nil
    }
}





