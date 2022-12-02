//
//  UpcomingTableViewCell.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-26.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

protocol UpcomingTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}

class UpcomingTableViewCell: UITableViewCell {
    
    weak var delegateUpcoming : HomeTableViewCellDelegate?
    
    static let identifer = "cellForInfoTable"
    
    static func nib() -> UINib {
        return UINib(nibName: "cellForInfoTable", bundle: nil)
    }

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var courseName: UILabel!
    

    @IBAction func onClickBtnView(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: ViewConstant.VIEW)
               
               delegateUpcoming?.didTapButton(with: title)
               
    }
    
    
    private var title : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
