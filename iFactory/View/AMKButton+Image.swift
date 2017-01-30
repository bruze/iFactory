//
//  AMKButton+Image.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import AssociatedValues
extension AMKButton {
    @IBInspectable weak var defaultImage: UIImage? {
        get {
            return getAssociatedValue(key: "defaultImage", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "defaultImage", object: self)
            if defaultImage != nil {
                resetView(imageContainer)
                images[AMKTypeTag.imageDefault] = defaultImage
                imageContainer = UIImageView.init(image: defaultImage!)
                addSubview(imageContainer)
                imageContainer.center = CGPoint.init(x: w / 2, y: h / 2)
            }
        }
    }
    @IBInspectable weak var pressImage: UIImage? {
        get {
            return getAssociatedValue(key: "pressImage", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "pressImage", object: self)
            images[AMKTypeTag.imagePressed] = pressImage
        }
    }
    @IBInspectable weak var disabledImage: UIImage? {
        get {
            return getAssociatedValue(key: "disabledImage", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "disabledImage", object: self)
            images[AMKTypeTag.imageDisabled] = disabledImage
        }
    }
    @IBInspectable var imageLeading: CGFloat {
        get {
            return getAssociatedValue(key: "imageLeading", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "imageLeading", object: self)
            imageContainer.center.x = w / 2 + imageLeading
        }
    }
    @IBInspectable var imageYOffset: CGFloat {
        get {
            return getAssociatedValue(key: "imageYOffset", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "imageYOffset", object: self)
            imageContainer.center.y = h / 2 + imageYOffset
        }
    }
    var imageContainer: UIImageView {
        get {
            return getAssociatedValue(key: "imageContainer", object: self, initialValue: UIImageView.init())
        }
        set {
            set(associatedValue: newValue, key: "imageContainer", object: self)
        }
    }
    internal func addImageViewWith(Image image: UIImage?, AndTag tag: AMKTypeTag) {
        guard image != nil else {
            return
        }
        let imageV = UIImageView.init(image: image)
        imageV.tag = tag.rawValue
        addSubview(imageV)
        imageV.center = CGPoint.init(x: w / 2, y: h / 2)
        setNeedsLayout()
    }
    internal func getImage(ForTag tag: AMKTypeTag) -> UIImage? {
        var image: UIImage? = nil
        switch tag {
        case .default:
            image = nil
        case .currentImage:
            image = nil
        case .imageDefault:
            image = images[tag]
        case .imageDisabled:
            image = images[tag]
        case .imagePressed:
            image = images[tag]
        case .labelDefault:
            image = nil
        }
        return image
    }
    internal func setImage(ForTag tag: AMKTypeTag) {
        if let toSet = getImage(ForTag: tag) {
            resetView(imageContainer)
            imageContainer = UIImageView.init(image: toSet)
            addSubview(imageContainer)
            imageContainer.center = CGPoint.init(x: w / 2 + imageLeading, y: h / 2 + imageYOffset)
        }
    }
}
