//
//  UIColor+Ext.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension UIColor {
    func isEmpty() -> Bool {
        return self == UIColor.clearColor()
    }
}