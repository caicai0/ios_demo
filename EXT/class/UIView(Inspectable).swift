//
//  UIView(Inspectable).swift
//  EXT
//
//  Created by 李玉峰 on 2017/5/3.
//  Copyright © 2017年 李玉峰. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var corverRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
