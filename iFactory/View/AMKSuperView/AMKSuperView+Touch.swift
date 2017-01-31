//
//  AMKSuperView+Touch.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
import EZSwiftExtensions
extension AMKSuperView {
    internal func addTouchImageView(_ origin: CGPoint, size: CGSize, image: UIImage) {
        touchImageView = UIImageView.init(x: origin.x, y: origin.y, w: size.width, h: size.height, image: image)
        touchImageView.isHidden = true
        addSubview(touchImageView)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isUserInteractionEnabled else { return }
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
                    self.idleImageView.isHidden.toggle()
                    self.touchImageView.isHidden.toggle()
                    blinked.toggle()
                } else if (self.touchImageView.isEmpty() && self.blinkIfNoTouchImage) {
                    self.backgroundColor = UIColor.clear
                    blinked.toggle()
                }
                if blinked && self.blinkLabelToo {
                    self.label.isHidden = true
                }
                self.setNeedsDisplay()
            })
            super.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isUserInteractionEnabled else { return }
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
            label.isHidden = false
            ez.runThisAfterDelay(seconds: 0.1, after: {
                self.delegatePerformTouch()
                super.touchesEnded(touches, with: event)
            })
        }
    }
    
    /*override func touchesEstimatedPropertiesUpdated(touches: Set<UITouch>) {
        print("estimatedUpdated")
    }*/
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if #available(iOS 9.1, *) {
            let contained = frame.contains((touches.first?.preciseLocation(in: self))!)
            if !contained {
                UIApplication.shared.beginIgnoringInteractionEvents()
                return
            }
        } else {
            // Fallback on earlier versions
        }
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.endIgnoringInteractionEvents()
        guard isUserInteractionEnabled else { return }
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
                idleImageView.isHidden.toggle()
                touchImageView.isHidden.toggle()
            } else if (touchImageView.isEmpty() && blinkIfNoTouchImage) {
                backgroundColor = backColor
            }
            label.isHidden = false
            
            super.touchesCancelled(touches, with: event)
        } else {
            
        }
    }
    internal func delegatePerformTouch() {
        if !touchBackColor.isEmpty() {
            backgroundColor = backColor
        }
        if !touchImageView.isEmpty() {
            idleImageView.isHidden.toggle()
            touchImageView.isHidden.toggle()
        } else if (touchImageView.isEmpty() && blinkIfNoTouchImage) {
            backgroundColor = backColor
        }
        setNeedsDisplay()
        guard !touchAction.isEmpty else {
            return
        }
        if let executer = delegate as? UIViewController {
            let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
            if executer.responds(to: aSelector) {
                executer.perform(aSelector, with: "")
            }
        } else if let executer = ez.topMostVC {
            let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
            if executer.responds(to: aSelector) {
                executer.performSelector(inBackground: aSelector, with: "")
            }
        }
    }
}
