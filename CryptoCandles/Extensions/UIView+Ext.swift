//
//  UIView+Ext.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get { return layer.cornerRadius }
    }
}
