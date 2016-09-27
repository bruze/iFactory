//
//  AMKSuperView+Touch.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBInspectable var blinkIfNoTouchImage: Bool {
        get {
            return getProperty("blinkOnTouch", initial: false)
        }
        set {
            setValue(newValue, forProperty: "blinkOnTouch")
        }
    }
    @IBInspectable var touchImage: UIImage {
        get {
            return getProperty("touchImage", initial: emptyImage)
        }
        set {
            setValue(newValue, forProperty: "touchImage")
            let size = newValue.size
            var setX = centerX - size.width / 2
            var setY = centerY - size.height / 2
            !touchPositionAngle.isZero && !touchPositionRadius.isZero ? {
                setX += cos(touchPositionAngle.degreesToRadians()) * touchPositionRadius
                setY -= sin(touchPositionAngle.degreesToRadians()) * touchPositionRadius
                }() : {}()
            addTouchImageView(CGPoint.init(x: setX, y: setY), size: size, image: touchImage)
        }
    }
    @IBInspectable var touchPositionAngle: CGFloat {
        get {
            return getProperty("touchPositionAngle", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "touchPositionAngle")
            updateImageViewLocation(touchPositionAngle, radius: touchPositionRadius, imageView: &touchImageView)
        }
    }
    @IBInspectable var touchPositionRadius: CGFloat {
        get {
            return getProperty("touchPositionRadius", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "touchPositionRadius")
            updateImageViewLocation(touchPositionAngle, radius: touchPositionRadius, imageView: &touchImageView)
        }
    }
    var touchImageView: UIImageView {
        get {
            return getProperty("touchImageView", initial: emptyImageView)
        }
        set {
            setValue(newValue, forProperty: "touchImageView")
        }
    }
    internal func addTouchImageView(origin: CGPoint, size: CGSize, image: UIImage) {
        touchImageView = UIImageView.init(x: origin.x, y: origin.y, w: size.width, h: size.height, image: image)
        touchImageView.hidden = true
        addSubview(touchImageView)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard userInteractionEnabled else { return }
        /*guard enabled else {
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
        }*/
        if enabled {
            backgroundColor = touchBackColor
            if !touchImageView.isEmpty() || blinkIfNoTouchImage {
                idleImageView.hidden.toggle()
                touchImageView.hidden.toggle()
            }
            super.touchesBegan(touches, withEvent: event)
        } else {
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard userInteractionEnabled else { return }
        /*guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.ImageDefault)
        setDefaultBackColor()
        delegatePerformTouch()*/
        if enabled {
            backgroundColor = backColor
            if !touchImageView.isEmpty() || blinkIfNoTouchImage {
                idleImageView.hidden.toggle()
                touchImageView.hidden.toggle()
            }
            super.touchesEnded(touches, withEvent: event)
        } else {
            
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        guard userInteractionEnabled else { return }
        /*guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.ImageDefault)
        setDefaultBackColor()*/
        if enabled {
            super.touchesCancelled(touches, withEvent: event)
        } else {
            
        }
    }
}