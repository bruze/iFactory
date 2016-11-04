//
//  AMKLabel+Inspectable.swift
//  iFactory
//
//  Created by Bruno Garelli on 10/31/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import UIKit

extension AMKLabel {
    @IBInspectable dynamic var curve: Bool {
        get {
            return getProperty("curve", initial: false)
        }
        set {
            setValue(newValue, forProperty: "curve")
        }
    }
    @IBInspectable dynamic var curveRadius: CGFloat {
        get {
            return getProperty("curveRadius", initial: 1)
        }
        set {
            setValue(newValue, forProperty: "curveRadius")
        }
    }
    @IBInspectable dynamic var curveAngle: CGFloat {
        get {
            return getProperty("curveAngle", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "curveAngle")
        }
    }
    @IBInspectable dynamic var curveClockwise: Bool {
        get {
            return getProperty("curveClockwise", initial: true)
        }
        set {
            setValue(newValue, forProperty: "curveClockwise")
        }
    }
    //MARK: Override Text
    @IBInspectable dynamic var overrideStoredText: Bool {
        get {
            return getProperty("overrideStoredText", initial: true)
        }
        set {
            setValue(newValue, forProperty: "overrideStoredText")
        }
    }
    @IBInspectable dynamic var overrideText: String {
        get {
            return getProperty("overrideText", initial: "")
        }
        set {
            setValue(newValue, forProperty: "overrideText")
        }
    }
    //MARK: Override Text Size
    @IBInspectable dynamic var overrideStoredTextSize: Bool {
        get {
            return getProperty("overrideStoredTextSize", initial: false)
        }
        set {
            setValue(newValue, forProperty: "overrideStoredTextSize")
        }
    }
    @IBInspectable dynamic var overrideTextSize: CGFloat {
        get {
            return getProperty("overrideTextSize", initial: 16)
        }
        set {
            setValue(newValue, forProperty: "overrideTextSize")
            let otherFont = textFont.fontWithSize(newValue)
            self.textFont = otherFont
            setNeedsDisplay()
        }
    }
    //MARK: Override Text Color
    @IBInspectable dynamic var overrideStoredTextColor: Bool {
        get {
            return getProperty("overrideStoredTextColor", initial: false)
        }
        set {
            setValue(newValue, forProperty: "overrideStoredTextColor")
            if newValue {
                textColor = overrideTextColor
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable dynamic var overrideTextColor: UIColor {
        get {
            return getProperty("overrideTextColor", initial: UIColor.blackColor())
        }
        set {
            setValue(newValue, forProperty: "overrideTextColor")
            if overrideStoredTextColor {
                textColor = newValue
                setNeedsDisplay()
            }
        }
    }
    //MARK: Mutate on Touch
    @IBInspectable dynamic var mutateOnTouch: Bool {
        get {
            return getProperty("mutateOnTouch", initial: false)
        }
        set {
            setValue(newValue, forProperty: "mutateOnTouch")
        }
    }
    @IBInspectable dynamic var mutateStoreID: String {
        get {
            return getProperty("mutateStoreID", initial: "")
        }
        set {
            setValue(newValue, forProperty: "mutateStoreID")
        }
    }
    //MARK: Action on Touch
    @IBInspectable dynamic var touchAction: String {
        get {
            return getProperty("touchAction", initial: "")
        }
        set {
            setValue(newValue, forProperty: "touchAction")
        }
    }
}