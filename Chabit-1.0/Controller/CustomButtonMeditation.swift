//
//  CustomButtonMeditation.swift
//  Chabit-1.0
//
//  Created by Pramahadi Tama Putra on 22/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import Foundation
import UIKit

class CustomButtonMeditation: UIButton{
    
}

extension CustomButtonMeditation {
    open override func awakeFromNib() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tintColor = #colorLiteral(red: 0.003507686313, green: 0.7306429744, blue: 0.8454419971, alpha: 1)
        layer.cornerRadius = 10
    }
}
