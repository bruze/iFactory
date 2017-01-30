//
//  AMKButton+Animation.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/13/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
typealias Move = Global.RLMove
extension AMKButton {
    @IBInspectable var showPassAtTap: Bool {
        get {
            return getAssociatedValue(key: "showPassAtTap", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "showPassAtTap", object: self)
        }
    }
    var lastMove: Move {
        get {
            return getAssociatedValue(key: "lastMove", object: self, initialValue: .left)
        }
        set {
            set(associatedValue: newValue, key: "lastMove", object: self)
        }
    }
    var layerLoaded: Bool {
        get {
            return getAssociatedValue(key: "layerLoaded", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "layerLoaded", object: self)
        }
    }
    var animLayer: CALayer {
        get {
            let pLayer = getAssociatedValue(key: "animLayer", object: self, initialValue: emptyLayer)
            if !layerLoaded {
                pLayer.frame = bounds
                pLayer.contentsRect = bounds
                pLayer.position = CGPoint.init(x: pLayer.position.x - bounds.width, y: pLayer.position.y)
                layer.addSublayer(pLayer)
                self.animLayer = pLayer
                layerLoaded = true
            }
            return pLayer
        }
        set {
            set(associatedValue: newValue, key: "animLayer", object: self)
        }
    }
    func passingLayerColor(_ color: UIColor, GoingRight right: Bool) {
        animLayer.backgroundColor = color.cgColor
        let animation = CABasicAnimation.init(keyPath: "position.x")
        animation.duration = 0.4
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        if lastMove == .left {
            lastMove = .right
            animation.fromValue = animLayer.position.x
            animation.toValue = animLayer.position.x + bounds.width * 2
        } else {
            lastMove = .left
            animation.fromValue = bounds.width * 2
            animation.toValue = animLayer.position.x - bounds.width
        }
        let sizeAnim = CABasicAnimation.init(keyPath: "bounds.width")
        if lastMove == .left {
            sizeAnim.fromValue = 0
            sizeAnim.toValue = bounds.width
        } else {
            sizeAnim.fromValue = bounds.w
            sizeAnim.toValue = 0
        }
        animLayer.add(animation, forKey: "position.x")
        animLayer.add(sizeAnim, forKey: "bounds.width")
    }
}
