//
//  AMKSuperView+Border.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
extension AMKSuperView {
    var hasBorder: Bool {
        get {
            return getAssociatedValue(key: "hasBorder", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "hasBorder", object: self)
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return getAssociatedValue(key: "borderColor", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "borderColor", object: self)
            borderWidth.isZero && !hasBorder ? {}() : { self.addBorder(width: self.borderWidth, color: newValue); self.hasBorder.toggle() }()
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return getAssociatedValue(key: "borderWidth", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "borderWidth", object: self)
            borderColor.isEmpty() && !hasBorder ? {}() : { addBorder(width: newValue, color: borderColor); self.hasBorder.toggle() }()
        }
    }
    @IBInspectable var roundCorners: CGFloat {
        get {
            return getAssociatedValue(key: "roundCorners", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "roundCorners", object: self)
            layer.cornerRadius = newValue
        }
    }
}
