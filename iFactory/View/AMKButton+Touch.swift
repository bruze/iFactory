//
//  AMKButton+Touch.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension AMKButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard enabled else {
            return
        }
        if let _ = getImage(ForTag: AMKTypeTag.imagePressed) {
            setImage(ForTag: AMKTypeTag.imagePressed)
        }
        if pressBackColor != nil {
            backgroundColor = pressBackColor
        }
        //encode()
        if showPassAtTap {
            passingLayerColor(UIColor.cyan, GoingRight: true)
        }
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.imageDefault)
        setDefaultBackColor()
        delegatePerformTouch()
        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.imageDefault)
        setDefaultBackColor()
        super.touchesCancelled(touches, with: event)
    }
}
