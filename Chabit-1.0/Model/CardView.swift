//
//  CardView.swift
//  CardViewTestLikeAppStore
//
//  Created by Willa on 17/07/19.
//  Copyright © 2019 WillaSaskara. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue/100
            
        }
    }
    
    @IBInspectable var shadowColor : CGColor {
        get {
            if let layer = layer.shadowColor{
                 return layer
            }
            return UIColor.gray.cgColor
        }
        set{
            layer.shadowColor = newValue
        }
        
    }
    
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layer.shadowColor = UIColor.black.cgColor
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable var borderSet: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.borderColor = #colorLiteral(red: 0, green: 0.7398331761, blue: 0.5932348371, alpha: 1)
        }
    }
    
    

    

}
