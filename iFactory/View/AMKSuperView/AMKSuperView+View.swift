//
//  AMKSuperView+View.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBInspectable var idleImageScale: CGFloat {
        get {
            return getProperty("idleImageScale", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "idleImageScale")
            let imageSize = idleImage.size
            let scaled = frame.getScaledSize(newValue, overSize: imageSize)
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView, newSize: scaled)
        }
    }
    @IBInspectable var fonta: CGFont {
        get {
            return getProperty("fonta", initial: CGFontCreateWithFontName("")!)
        }
        set {
            setValue(newValue, forProperty: "fonta")
        }
    }
}