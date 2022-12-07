//
//  WellDoneViewController.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-12-03.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class WellDoneViewController: UIViewController {
    
    
    @IBOutlet weak var welldone: UIImageView!
    
    var upComingArray:[SubmissionObject]=[]
    var completedArray:[SubmissionObject]=[]
    
    
    override func viewDidAppear(_ animated: Bool) {
        animate()
        
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.addSubview(welldone)
 
    }
    
    
    @objc func animate()
    {
        UIView.animate(withDuration: 1, animations: {
            self.welldone.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            self.welldone.center = self.view.center
        }, completion: { done in
            if done {
                self.shrink()
            }
            
        })
    }
    
    func shrink(){
        UIView.animate(withDuration: 1, animations: {
            self.welldone.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            self.welldone.center = self.view.center
        }, completion: { done in
            
                self.animate()
        
            
        })
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier=="goToHome" {
                let destinationVC=segue.destination as! HomeViewController
            
                    destinationVC.completedArray = completedArray
                    destinationVC.upComingArray = upComingArray
                 
                    
                }
                
            }
}
