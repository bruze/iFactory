//
//  AMKButton+View.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension AMKButton {
    @IBInspectable weak var defaultBackColor: UIColor? {
        get {
            return getProperty("defaultBackColor", initial: UIColor.whiteColor())
        }
        set {
            setValue(newValue, forProperty: "defaultBackColor")
            setDefaultBackColor()
        }
    }
    @IBInspectable weak var pressBackColor: UIColor? {
        get {
            return getProperty("pressBackColor", initial: UIColor.grayColor())
        }
        set {
            setValue(newValue, forProperty: "pressBackColor")
        }
    }
    internal func resetView(view: UIView?) -> Bool {
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
