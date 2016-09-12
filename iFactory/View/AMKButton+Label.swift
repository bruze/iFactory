//
//  AMKButton+Label.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/5/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import PropertyExtensions

extension AMKButton {
    var currentDefaultLabel: UILabel? {
        get {
            if let view = viewWithTag(AMKTypeTag.LabelDefault.rawValue) {
                return view as? UILabel
            }
            return nil
        }
    }
    @IBInspectable override var defaultLabel: String {
        didSet {
            resetView(currentDefaultLabel)
            if !defaultLabel.isEmpty {
                addLabelWith(Text: defaultLabel, AndOffset: CGPoint.zero)
            }
        }
    }
    @IBInspectable var defLabelXOffset: CGFloat {
        get {
            return getProperty("defLabelXOffset", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "defLabelXOffset")
            currentDefaultLabel?.origin = CGPoint.init(x: defLabelXOffset, y: defLabelYOffset)
            /*if labelRelativeImage == 0 {
                //currentDefaultLabel?.origin.x += defLabelXOffset
            } else {
                //print(labelRelativeImage)
            }*/
        }
    }
    @IBInspectable var defLabelYOffset: CGFloat {
        get {
            return getProperty("defLabelYOffset", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "defLabelYOffset")
            currentDefaultLabel?.origin = CGPoint.init(x: defLabelXOffset, y: defLabelYOffset)
            /*if labelRelativeImage == 0 {
                currentDefaultLabel?.origin.y += defLabelYOffset
            } else {
                //print(labelRelativeImage)
            }*/
        }
    }
    @IBInspectable var labelFontColor: UIColor {
        get {
            return getProperty("labelFontColor", initial: defaultOverlapLabelFontColor)
        }
        set {
            setValue(newValue, forProperty: "labelFontColor")
            currentDefaultLabel?.textColor = newValue
        }
    }

    @IBInspectable var labelFontName: String {
        get {
            return getProperty("labelFontName", initial: defaultOverlapLabelFontName)
        }
        set {
            setValue(newValue, forProperty: "labelFontName")
            let font = UIFont.init(name: newValue, size: labelFontSize)
            currentDefaultLabel?.font = font
        }
    }

    @IBInspectable var labelFontSize: CGFloat {
        get {
            return getProperty("labelFontSize", initial: defaultOverlapLabelFontSize)
        }
        set {
            setValue(newValue, forProperty: "labelFontSize")
            let font = UIFont.init(name: labelFontName, size: newValue)
            currentDefaultLabel?.font = font
        }
    }
    internal func addLabelWith(Text labelText: String, AndOffset offset: CGPoint) {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, w: w - (w/6), h: h - (h / 4)))
        label.tag = AMKTypeTag.LabelDefault.rawValue
        label.text = labelText
        addSubview(label)
        label.origin = CGPoint.init(x: defLabelXOffset, y: defLabelYOffset)
        //label.centerYInSuperView()
        /*if let image = currentImage where labelRelativeImage != 0 {
            currentDefaultLabel?.origin.x = image.origin.x + image.w + labelRelativeImage
        }*/
        //updateViews()
    }
}
