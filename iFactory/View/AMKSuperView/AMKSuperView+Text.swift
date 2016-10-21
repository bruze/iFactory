//
//  AMKSuperView+Text.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBOutlet weak var label: UILabel! {
        get {
            return getProperty("label", initial: UILabel.init())
        }
        set {
            let newFrame = /*newValue.*/frame
            let newLabel = UILabel.init(x: newFrame.x, y: newFrame.y, w: newFrame.w, h: newFrame.h, fontSize: newValue.font.pointSize)
            setValue(newLabel, forProperty: "label")
            label.text = newValue.text
            label.textColor = newValue.textColor
            label.textAlignment = newValue.textAlignment
            label.font = newValue.font
            /*label.curve = newValue.curve
            label.curveRadius = newValue.curveRadius
            label.curveAngle = newValue.curveAngle
            label.curveClockwise = newValue.curveClockwise*/
            
            newValue.hidden = true
            newValue.enabled = false
            //label.drawRect(label.bounds)
            addSubview(label)
            label.center = center
            label.drawRect(newFrame)
            //label.centerInSuperView()
        }
    }
}
