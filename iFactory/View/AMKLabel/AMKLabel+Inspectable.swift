//
//  AMKLabel+Inspectable.swift
//  iFactory
//
//  Created by Bruno Garelli on 10/31/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import UIKit
import AssociatedValues
extension AMKLabel {
    @IBInspectable dynamic var curve: Bool {
        get {
            return getAssociatedValue(key: "curve", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "curve", object: self)
        }
    }
    @IBInspectable dynamic var curveRadius: CGFloat {
        get {
            return getAssociatedValue(key: "curveRadius", object: self, initialValue: 1)
        }
        set {
            set(associatedValue: newValue, key: "curveRadius", object: self)
        }
    }
    @IBInspectable dynamic var curveAngle: CGFloat {
        get {
            return getAssociatedValue(key: "curveAngle", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "curveAngle", object: self)
        }
    }
    @IBInspectable dynamic var curveClockwise: Bool {
        get {
            return getAssociatedValue(key: "curveClockwise", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "curveClockwise", object: self)
        }
    }
    //MARK: Override Text
    @IBInspectable dynamic var overrideStoredText: Bool {
        get {
            return getAssociatedValue(key: "overrideStoredText", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "overrideStoredText", object: self)
        }
    }
    @IBInspectable dynamic var overrideText: String {
        get {
            return getAssociatedValue(key: "overrideText", object: self, initialValue: "overrideText")
        }
        set {
            set(associatedValue: newValue, key: "overrideText", object: self)
        }
    }
    //MARK: Override Text Size
    @IBInspectable dynamic var overrideStoredTextSize: Bool {
        get {
            return getAssociatedValue(key: "overrideStoredTextSize", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "overrideStoredTextSize", object: self)
        }
    }
    @IBInspectable dynamic var overrideTextSize: CGFloat {
        get {
            return getAssociatedValue(key: "overrideTextSize", object: self, initialValue: 16)
        }
        set {
            set(associatedValue: newValue, key: "overrideTextSize", object: self)
            let otherFont = textFont.withSize(newValue)
            self.textFont = otherFont
            setNeedsDisplay()
        }
    }
    //MARK: Override Text Color
    @IBInspectable dynamic var overrideStoredTextColor: Bool {
        get {
            return getAssociatedValue(key: "overrideStoredTextColor", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "overrideStoredTextColor", object: self)
            if newValue {
                textColor = overrideTextColor
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable dynamic var overrideTextColor: UIColor {
        get {
            return getAssociatedValue(key: "overrideTextColor", object: self, initialValue: UIColor.black)
        }
        set {
            set(associatedValue: newValue, key: "overrideTextColor", object: self)
            if overrideStoredTextColor {
                textColor = newValue
                setNeedsDisplay()
            }
        }
    }
    //MARK: Mutate on Touch
    @IBInspectable dynamic var mutateOnTouch: Bool {
        get {
            return getAssociatedValue(key: "mutateOnTouch", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "mutateOnTouch", object: self)
        }
    }
    @IBInspectable dynamic var mutateStoreID: String {
        get {
            return getAssociatedValue(key: "mutateStoreID", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "mutateStoreID", object: self)
        }
    }
    //MARK: Action on Touch
    @IBInspectable dynamic var touchAction: String {
        get {
            return getAssociatedValue(key: "touchAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "touchAction", object: self)
        }
    }
}
