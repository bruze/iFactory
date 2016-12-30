//
//  AMKSuperView+Touch.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import EZSwiftExtensions
extension AMKSuperView {
    @IBInspectable var blinkIfNoTouchImage: Bool {
        get {
            return getProperty("blinkOnTouch", initial: false)
        }
        set {
            setValue(newValue, forProperty: "blinkOnTouch")
        }
    }
    @IBInspectable var blinkLabelToo: Bool {
        get {
            return getProperty("blinkLabelToo", initial: false)
        }
        set {
            setValue(newValue, forProperty: "blinkLabelToo")
        }
    }
    @IBInspectable var touchImage: UIImage {
        get {
            return getProperty("touchImage", initial: emptyImage)
        }
        set {
            setValue(newValue, forProperty: "touchImage")
            let size = newValue.size
            //var setX = centerX - size.width / 2
            //var setY = centerY - size.height / 2
            var setX = /*centerX*/frame.size.width / 2 - size.width / 2
            var setY = /*centerY*/frame.size.height / 2 - size.height / 2
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
        /*encode()
        if showPassAtTap {
            passingLayerColor(UIColor.cyanColor(), GoingRight: true)
        }*/
        if enabled {
            ez.runThisInMainThread({ 
                if !self.touchBackColor.isEmpty() {
                    self.backgroundColor = self.touchBackColor
                }
                var blinked = false
                if !self.touchImageView.isEmpty() {
                    self.idleImageView.hidden.toggle()
                    self.touchImageView.hidden.toggle()
                    blinked.toggle()
                } else if (self.touchImageView.isEmpty() && self.blinkIfNoTouchImage) {
                    self.backgroundColor = UIColor.clearColor()
                    blinked.toggle()
                }
                if blinked && self.blinkLabelToo {
                    self.label.hidden = true
                }
                self.setNeedsDisplay()
            })
            super.touchesBegan(touches, withEvent: event)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard userInteractionEnabled else { return }
        /*guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.ImageDefault)
        setDefaultBackColor()*/
        if enabled {
            /*if !touchBackColor.isEmpty() {
                backgroundColor = backColor
            }
            if !touchImageView.isEmpty() {
                idleImageView.hidden.toggle()
                touchImageView.hidden.toggle()
            } else if (touchImageView.isEmpty() && blinkIfNoTouchImage) {
                backgroundColor = backColor
            }*/
            label.hidden = false
            ez.runThisAfterDelay(seconds: 0.1, after: {
                self.delegatePerformTouch()
                super.touchesEnded(touches, withEvent: event)
            })
        }
    }
    
    /*override func touchesEstimatedPropertiesUpdated(touches: Set<UITouch>) {
        print("estimatedUpdated")
    }*/
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if #available(iOS 9.1, *) {
            let contained = frame.contains((touches.first?.preciseLocationInView(self))!)
            if !contained {
                UIApplication.sharedApplication().beginIgnoringInteractionEvents()
                return
            }
        } else {
            // Fallback on earlier versions
        }
        super.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
        guard userInteractionEnabled else { return }
        /*guard enabled else {
            return
        }
        setImage(ForTag: AMKTypeTag.ImageDefault)
        setDefaultBackColor()*/
        if enabled {
            if !touchBackColor.isEmpty() {
                backgroundColor = backColor
            }
            if !touchImageView.isEmpty() {
                idleImageView.hidden.toggle()
                touchImageView.hidden.toggle()
            } else if (touchImageView.isEmpty() && blinkIfNoTouchImage) {
                backgroundColor = backColor
            }
            label.hidden = false
            
            super.touchesCancelled(touches, withEvent: event)
        } else {
            
        }
    }
    internal func delegatePerformTouch() {
        if !touchBackColor.isEmpty() {
            backgroundColor = backColor
        }
        if !touchImageView.isEmpty() {
            idleImageView.hidden.toggle()
            touchImageView.hidden.toggle()
        } else if (touchImageView.isEmpty() && blinkIfNoTouchImage) {
            backgroundColor = backColor
        }
        setNeedsDisplay()
        guard !touchAction.isEmpty else {
            return
        }
        if let executer = delegate as? UIViewController {
            let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
            if executer.respondsToSelector(aSelector) {
                executer.performSelector(aSelector, withObject: "")
            }
        } else if let executer = ez.topMostVC {
            let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
            if executer.respondsToSelector(aSelector) {
                executer.performSelector(aSelector, withObject: "")
            }
        }
    }
}
