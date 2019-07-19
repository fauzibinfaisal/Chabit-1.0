//
//  CustomTableViewCell.swift
//  CardViewTestLikeAppStore
//
//  Created by Willa on 18/07/19.
//  Copyright © 2019 WillaSaskara. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
  
    @IBOutlet var cellTextLabel: UILabel!
    
    @IBOutlet var minuteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
