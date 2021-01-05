//
//  discoveryCellCollectionViewCell.swift
//  Downtown
//
//  Created by Aaron Marsh on 5/17/20.
//  Copyright © 2020 Aaron Marsh. All rights reserved.
//

import UIKit

class discoveryCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var brandLogo: UIImageView!

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var about: UITextView!
    @IBOutlet weak var brandName: UILabel!
    private func imageSetUp() {
  
        
        brandLogo.layer.cornerRadius = 30
        brandLogo.clipsToBounds = true
        
        brandLogo.contentMode = .scaleAspectFill
    }
    
    func setUP() {
//     let card = imageHolder.layer
////
//        card.borderWidth = 0.001
        imageSetUp()
    }
    
    override func awakeFromNib() {
        
        setUP()
        super.awakeFromNib()
        // Initialization code
    }

}


