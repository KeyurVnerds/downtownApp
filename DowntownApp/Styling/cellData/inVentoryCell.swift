//
//  inVentoryCell.swift
//  Downtown
//
//  Created by Aaron Marsh on 7/24/19.
//  Copyright © 2019 Zinc. All rights reserved.
//
 
 var switchB = 2
import UIKit
import Firebase
 



class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet var myButton: UIButton!
}
class inVentoryCell: UICollectionViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imageD: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var holderV: UIView!
    
    @IBOutlet weak var dataH: UIView!
    
 
    @IBOutlet weak var activityIndi: UIActivityIndicatorView!
    
    
    
    
    
    
    
    
    @IBOutlet weak var unsavedItem: UIImageView!
    
    
    
//    @IBAction func saveitem(_ sender: Any) {
// 
//  
//        
//        switchB += 1
//        
//        if switchB % 2 == 0 {
//            
//         //even Number
//              unsavedItem.image = UIImage(named: "SavedItem")
//            print(IndexPath())
//            
//        } else {
//         // Odd number
//            unsavedItem.image = UIImage(named: "unsavedItem")
//            print(IndexPath())
//        }
////        if switchB == 1 {
////        unsavedItem.image = UIImage(named: "SavedItem")
////
////
////            if switchB == 0 {
////                        unsavedItem.image = UIImage(named: "unsaveitem")
////            }
////        }
//        
//    print(switchB)
//    }
      var onBookMarkHandler: (()-> ())? = nil
       
       @IBAction func saveitem(_ sender: Any) {
    
     bookMark()
       print(switchB)
       }
       func bookMark()  {
           onBookMarkHandler?()
           
       }


    @IBOutlet weak var shop_name: UILabel!
    

    
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var bookMarkH: UIView!
    override func awakeFromNib() {
        
 
        
        
        imageD.contentMode = .scaleAspectFill
        
        shop_name.layer.cornerRadius = 7
        
        shop_name.alpha = 0.7
        
        shop_name.text = "Record Place"
        
        shop_name.clipsToBounds = true
        
       
//        bookMarkB.frame.size = CGSize(width: bookMarkV.frame.width, height: bookMarkV.frame.height)
        print("nib works")

        super.awakeFromNib()
        // Initialization code
        imageD.layer.cornerRadius = 10
        
        
             

        }
        }
    


