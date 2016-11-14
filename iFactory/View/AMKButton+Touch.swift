//
//  AMKButton+Touch.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension AMKButton {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard enabled else {
            return
        }
        if let _ = getImage(ForTag: AMKTypeTag.ImagePressed) {
            setImage(ForTag: AMKTypeTag.ImagePressed)
        }
        if pressBackColor != nil {
            backgroundColor = pressBackColor
        }
        //encode()
        if showPassAtTap {
            passingLayerColor(UIColor.cyanColor(), GoingRight: true)
        }
        super.touchesBegan(touches, withEvent: event)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.ImageDefault)
        setDefaultBackColor()
        delegatePerformTouch()
        super.touchesEnded(touches, withEvent: event)
    }

    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.ImageDefault)
        setDefaultBackColor()
        super.touchesCancelled(touches, withEvent: event)
    }
}
