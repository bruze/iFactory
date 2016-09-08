//
//  AMKButton+Image.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension AMKButton {
    @IBInspectable weak var defaultImage: UIImage? {
        get {
            return getProperty("defaultImage", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "defaultImage")
            resetView(currentImage)
            if defaultImage != nil {
                images[AMKTypeTag.ImageDefault] = defaultImage
                addImageViewWith(Image: defaultImage!, AndTag: AMKTypeTag.CurrentImage)
            }
        }
    }
    @IBInspectable weak var pressImage: UIImage? {
        get {
            return getProperty("pressImage", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "pressImage")
            images[AMKTypeTag.ImagePressed] = pressImage
        }
    }
    @IBInspectable weak var disabledImage: UIImage? {
        get {
            return getProperty("disabledImage", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "disabledImage")
            images[AMKTypeTag.ImageDisabled] = disabledImage
        }
    }
    internal func addImageViewWith(Image image: UIImage?, AndTag tag: AMKTypeTag) {
        guard image != nil else {
            return
        }
        let imageV = UIImageView.init(image: image)
        imageV.tag = tag.rawValue
        addSubview(imageV)
        imageV.centerYInSuperView()
        updateViews()
    }
    internal func getImage(ForTag tag: AMKTypeTag) -> UIImage? {
        var image: UIImage? = nil
        switch tag {
        case .Default:
            image = nil
        case .CurrentImage:
            image = nil
        case .ImageDefault:
            image = images[tag]
        case .ImageDisabled:
            image = images[tag]
        case .ImagePressed:
            image = images[tag]
        case .LabelDefault:
            image = nil
        }
        return image
    }
    internal func setImage(ForTag tag: AMKTypeTag) {
        resetView(currentImage)
        addImageViewWith(Image: getImage(ForTag: tag), AndTag: .CurrentImage)
    }
}
