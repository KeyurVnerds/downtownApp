//
//  itemLog.swift
//  
//
//  Created by Aaron Marsh on 5/20/20.
//

import Foundation
import UIKit

public var globalProductPrice = ""
public var globalProductName = ""
public var globalProductId = ""
public var globalBase = ""

public func setItemProperties(name: String, price: String,id: String, base: String) {
    
  
    globalProductPrice = price
    globalProductName = name
    globalProductId = id
    globalBase = base
    
    
    
}

public func imageCycle (array: Array<String>, imageView: UIImageView) -> Array<UIImage>{
    var image_Array = [UIImage]()
          for word in array {
            print(word)
            let url = URL(string: word )
            URLSession.shared.dataTask(with: url!) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else { return }
                DispatchQueue.main.async() {
                image_Array.append(image)
                   
                imageView.image = image_Array[0]

            }
            }.resume()
           
    
}
return image_Array
}
