//
//  CompletedTableTableViewCell.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-12-06.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class CompletedTableTableViewCell: UITableViewCell {

     weak var delegateCompleted : HomeTableViewCellDelegate?
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var course: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
