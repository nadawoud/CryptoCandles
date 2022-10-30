//
//  UIViewController+Ext.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 30/10/2022.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}


extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
