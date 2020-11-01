//
//  homePage.swift
//  Downtown
//
//  Created by Aaron Marsh on 3/22/20.
//  Copyright © 2020 Aaron Marsh. All rights reserved.
//

import Foundation
import UIKit

public func images(scroll: UIView, spacee:Int, fetchId: String) -> UIImageView{
    let number = Int.random(in: 0 ... 2)
print(number)
    
    
    let space = CGFloat(393 * spacee)
    let view = UIView()
       view.frame.size = CGSize(width: 343, height: 343)
    let image = UIImageView()
    view.frame.origin = CGPoint(x: scroll.center.x - (view.frame.width) / 2, y: 700 + space)
    image.frame.size = CGSize(width: 343, height: 343)
    image.contentMode = .scaleAspectFill
    image.backgroundColor = .gray
    image.image = UIImage(named: "bike")
    image.layer.borderWidth = 2
    image.clipsToBounds = true
    image.layer.cornerRadius = 10
    image.clipsToBounds = true
    view.addSubview(image)
    scroll.addSubview(view)
    
    // Label
    
    let label = UILabel()
    
    label.frame.size = CGSize(width: view.frame.width, height: 50)
    
    label.font = UIFont(name: "Rockwell-Bold", size: 25)
    
    label.backgroundColor = .black
    
    label.textColor = .white
    
    label.text = ""
    
    label.textAlignment = .center
    
 
    label.layer.cornerRadius = 10
    view.addSubview(label)
    
    view.backgroundColor = .black
    
    view.clipsToBounds = true
    
    view.layer.cornerRadius = 10
    
    // Text
    //Theme


        
        label.backgroundColor = .black
              label.textColor = .white
          
        
    

        image.kf.setImage(with: URL(string: fetchId))
    return image
}







