//
//  BasicStuff.swift
//  DowntownApp
//
//  Created by keyur on 6/1/2564 BE.
//  Copyright © 2564 Aaron Marsh. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}
