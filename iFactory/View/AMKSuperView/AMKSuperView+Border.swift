//
//  AMKSuperView+Border.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    var hasBorder: Bool {
        get {
            return getProperty("hasBorder", initial: false)
        }
        set {
            setValue(newValue, forProperty: "hasBorder")
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return getProperty("borderColor", initial: UIColor.clearColor())
        }
        set {
            setValue(newValue, forProperty: "borderColor")
            borderWidth.isZero && !hasBorder ? {}() : { self.addBorder(width: self.borderWidth, color: newValue); self.hasBorder.toggle() }()
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return getProperty("borderWidth", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "borderWidth")
            borderColor.isEmpty() && !hasBorder ? {}() : { addBorder(width: newValue, color: borderColor); self.hasBorder.toggle() }()
        }
    }
    @IBInspectable var roundCorners: CGFloat {
        get {
            return getProperty("roundCorners", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "roundCorners")
            layer.cornerRadius = newValue
        }
    }
}