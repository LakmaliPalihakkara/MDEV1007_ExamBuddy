//
//  HomeTableViewCell.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-22.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}

class HomeTableViewCell: UITableViewCell {

    weak var delegate : HomeTableViewCellDelegate?
    
    static let identifer = "cellForInfoTable"
    
    static func nib() -> UINib {
        return UINib(nibName: "cellForInfoTable", bundle: nil)
    }
    
    @IBOutlet weak var assignmentName: UILabel!
    
    @IBOutlet weak var courseName: UILabel!
    
    @IBOutlet weak var dueDate: UILabel!
    
    @IBOutlet weak var btnView: UIButton!
    
    private var title : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    //    btnView.setTitleColor(.link, for: .normal)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with title: String)
    {
        self.title = title
        print ("indexttle \(title)")
    }
    
    
    
   

}

struct ViewConstant {
       static var VIEW = "View"
          
      }
