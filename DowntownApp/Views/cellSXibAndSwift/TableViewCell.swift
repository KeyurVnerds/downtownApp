//
//  TableViewCell.swift
//  TableView+CustomCellDemo
//
//  Created by Khaled L Said on 12/18/20.
//  Copyright © 2020 fiverWork. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var productName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3))
         selectionStyle = .none
    }
//
//    func configureCellData(data: order_data) {
//        
//        
//        self.productName.text = data.name
//        self.companyName.text = data.shop
//        self.price.text = "$59.99"
//        self.productImage.kf.setImage(with: URL(string: data.image))
//        self.productImage.
//        
//    }

    
    
 
}
