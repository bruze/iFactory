//
//  AMKSuperView+View.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
extension AMKSuperView {
    @IBInspectable var idleImageScale: CGFloat {
        get {
            return getAssociatedValue(key: "idleImageScale", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "idleImageScale", object: self)
            let imageSize = idleImage.size
            let scaled = frame.getScaledSize(newValue, overSize: imageSize)
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView, newSize: scaled)
        }
    }
    @IBInspectable var fonta: CGFont {
        get {
            let initialStr: CFString = "" as CFString
            return getAssociatedValue(key: "fonta", object: self, initialValue: CGFont.init(initialStr)!)
        }
        set {
            set(associatedValue: newValue, key: "fonta", object: self)
        }
    }
}
