//
//  AMKButton+View.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit

extension AMKButton {
    @IBInspectable weak var defaultBackColor: UIColor? {
        get {
            return getAssociatedValue(key: "defaultBackColor", object: self, initialValue: UIColor.white)
        }
        set {
            set(associatedValue: newValue, key: "defaultBackColor", object: self)
            setDefaultBackColor()
        }
    }
    @IBInspectable weak var pressBackColor: UIColor? {
        get {
            return getAssociatedValue(key: "pressBackColor", object: self, initialValue: UIColor.gray)
        }
        set {
            set(associatedValue: newValue, key: "pressBackColor", object: self)
        }
    }
    internal func resetView(_ view: UIView?) -> Bool {
        if let unwrap = view {
            unwrap.removeSubviews()
            unwrap.removeFromSuperview()
            return true
        }
        return false
    }

    /*internal func updateViews() {
        currentImage?.origin.x = origin.x + imageLeading
        print(currentImage?.origin.x)
        if let image = currentImage where labelRelativeImage != 0 {
            currentDefaultLabel?.origin.x = image.origin.x + image.w + labelRelativeImage
        }
    }*/

    internal func setDefaultBackColor() {
        if defaultBackColor != nil {
            backgroundColor = defaultBackColor
        }
    }
}
