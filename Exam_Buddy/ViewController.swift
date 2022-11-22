//
//  ViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-08.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
        @IBOutlet weak var usernameTextField: UITextField!
        
        @IBOutlet weak var passwordTextField: UITextField!
        
        @IBOutlet weak var loginBtn: UIButton!
        
        let userObj: UserObject = UserObject()

        
        override func viewDidLoad() {
            super.viewDidLoad()

            loginBtn.layer.cornerRadius = 10;

        
            
        }
        
        
        
        @IBAction func btnLogin(_ sender: Any) {

//            let decoder = JSONDecoder()
//            if let userData = UserDefaults.standard.data(forKey: "user"),
//                let user = try? decoder.decode(UserObject.self, from: userData) {
//
//        if(user.username != usernameTextField.text)
//            {
//                usernameTextField.text = ""
//
//                usernameTextField.attributedPlaceholder = NSAttributedString(
//                    string: "Please enter correct username",
//                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
//                )
//
//            }
//            else if(user.password != passwordTextField.text)
//            {
//                passwordTextField.text = ""
//
//                passwordTextField.attributedPlaceholder = NSAttributedString(
//                    string: "Please enter correct password",
//                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
//                )
//            }
//            else
//            {
//                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! HomeViewController
//                self.present(balanceViewController, animated: true, completion: nil)
//            }
//            }
//        }
//

    }



//    extension CALayer {
//
//        func addRadius(_ corners: UIRectCorner, radius: CGFloat, view: UIView) {
//            let mask = CAShapeLayer()
//            mask.bounds = view.frame
//            mask.position = view.center
//            mask.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
//            view.layer.mask = mask
//        }
//
//        func addRadius(radius: CGFloat) {
//            self.cornerRadius = radius
//        }
//    }
//
//
//
//    extension UserDefaults {
//
//        func save<T: Codable>(_ object: T, forKey key: String) {
//            let encoder = JSONEncoder()
//            if let encodedObject = try? encoder.encode(object) {
//                UserDefaults.standard.set(encodedObject, forKey: key)
//                UserDefaults.standard.synchronize()
//            }
//        }
//
//        func getObject<T: Codable>(forKey key: String) -> T? {
//            if let object = UserDefaults.standard.object(forKey: key) as? Data {
//                let decoder = JSONDecoder()
//                if let decodedObject = try? decoder.decode(T.self, from: object) {
//                    return decodedObject
//                }
//            }
//            return nil
//        }
    }





