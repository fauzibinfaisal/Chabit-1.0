//
//  CustomButton.swift
//  Chabit-1.0
//
//  Created by Pramahadi Tama Putra on 18/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
}

extension CustomButton{
    open override func awakeFromNib() {
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tintColor = #colorLiteral(red: 0.1176470588, green: 0.7411764706, blue: 0.6666666667, alpha: 1)
        layer.cornerRadius = 10
    }
}
