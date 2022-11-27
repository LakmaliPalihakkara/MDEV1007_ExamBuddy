//
//  UpcomingTableViewCell.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-26.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
