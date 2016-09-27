//
//  AMKSuperView+Background.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBInspectable var backColor: UIColor {
        get {
            return getProperty("defBackColor", initial: UIColor.clearColor())
        }
        set {
            setValue(newValue, forProperty: "defBackColor")
            backgroundColor = newValue
        }
    }
    @IBInspectable var touchBackColor: UIColor {
        get {
            return getProperty("touchBackColor", initial: UIColor.clearColor())
        }
        set {
            setValue(newValue, forProperty: "touchBackColor")
        }
    }
}