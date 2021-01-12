//
//  OrderHistoryCell.swift
//  DowntownApp
//
//  Created by keyur on 9/1/2564 BE.
//  Copyright © 2564 Aaron Marsh. All rights reserved.
//

import UIKit

class OrderHistoryCell: UITableViewCell {
    @IBOutlet weak var lblQuntyValue: UILabel!
    
    @IBOutlet weak var lblNameValue: UILabel!
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
