//
//  AMKSuperView+Background.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
extension AMKSuperView {
    @IBInspectable var backColor: UIColor {
        get {
            return getAssociatedValue(key: "defBackColor", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "defBackColor", object: self)
            backgroundColor = newValue
        }
    }
    @IBInspectable var touchBackColor: UIColor {
        get {
            return getAssociatedValue(key: "touchBackColor", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "touchBackColor", object: self)
        }
    }
}
