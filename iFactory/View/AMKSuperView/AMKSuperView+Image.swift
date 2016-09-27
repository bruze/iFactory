//
//  AMKSuperView+Image.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBInspectable var idleImage: UIImage {
        get {
            return getProperty("idleImage", initial: emptyImage)
        }
        set {
            setValue(newValue, forProperty: "idleImage")
            var size = newValue.size
            var setX = centerX - size.width / 2
            var setY = centerY - size.height / 2
            !idlePositionAngle.isZero && !idlePositionRadius.isZero ? {
                setX += cos(idlePositionAngle.degreesToRadians()) * idlePositionRadius
                setY -= sin(idlePositionAngle.degreesToRadians()) * idlePositionRadius
            }() : {}()
            if idleImageScale != 0 {
                size = frame.getScaledSize(idleImageScale, overSize: newValue.size)
            }
            addIdleImageView(CGPoint.init(x: setX, y: setY), size: size, image: newValue)
        }
    }
    @IBInspectable var idlePositionAngle: CGFloat {
        get {
            return getProperty("idlePositionAngle", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "idlePositionAngle")
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView)
        }
    }
    @IBInspectable var idlePositionRadius: CGFloat {
        get {
            return getProperty("idlePositionRadius", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "idlePositionRadius")
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView)
        }
    }
    var idleImageView: UIImageView {
        get {
            return getProperty("idleImageView", initial: emptyImageView)
        }
        set {
            setValue(newValue, forProperty: "idleImageView")
        }
    }
    internal func addIdleImageView(origin: CGPoint, size: CGSize, image: UIImage) {
        idleImageView = UIImageView.init(x: origin.x, y: origin.y, w: size.width, h: size.height, image: image)
        addSubview(idleImageView)
    }
    internal func updateImageViewLocation(angle: CGFloat, radius: CGFloat, inout imageView: UIImageView, newSize: CGSize? = nil) {
        guard !imageView.isEmpty() && imageView.image != nil else {
            return
        }
        let image = imageView.image!
        var size = newSize != nil ? newSize! : image.size
        var setX = centerX - size.width / 2
        var setY = centerY - size.height / 2
        if !angle.isZero && !radius.isZero {
            setX += cos(angle.degreesToRadians()) * radius
            setY -= sin(angle.degreesToRadians()) * radius
        }
        if idleImageScale != 0 {
            size = frame.getScaledSize(idleImageScale, overSize: idleImage.size)
        }
        imageView.frame = CGRect.init(x: setX, y: setY, w: size.width, h: size.height)
    }
}