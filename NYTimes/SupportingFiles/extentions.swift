//
//  extentions.swift
//  NYTimes
//
//  Created by Azza on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit
import Foundation

extension UIView{
    
    // corner radius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
        
    // border width
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    // border color
    @IBInspectable
    var borderColor: UIColor{
        get {
            return self.borderColor
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    // shadow color
    @IBInspectable
    var shadowColor: UIColor{
        get {
            return self.shadowColor
        }
        set {
            self.layer.shadowColor = newValue.cgColor
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowOpacity = 1
            self.layer.shadowRadius = 4
            self.layer.masksToBounds = false
        }
    }
}


