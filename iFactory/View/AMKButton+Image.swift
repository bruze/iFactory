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
            //resetView(currentImage)
            if defaultImage != nil {
                resetView(imageContainer)
                images[AMKTypeTag.ImageDefault] = defaultImage
                imageContainer = UIImageView.init(image: defaultImage!)
                addSubview(imageContainer)
                //imageContainer.centerInSuperView()
                //addSubview(imageContainer)
                //imageContainer.origin.x += defaultImage!.size.width / 2 + size.width / 2
                //imageContainer.origin.y += defaultImage!.size.height / 2 + size.height / 2
                //imageContainer.centerInSuperView()
                imageContainer.center = CGPoint.init(x: w / 2 /*- defaultImage!.size.width / 2*/, y: h / 2 /*- defaultImage!.size.height / 2*/)
                //setImage(ForTag: AMKButton.AMKTypeTag.ImageDefault)
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
    var imageContainer: UIImageView {
        get {
            /*if let view = viewWithTag(AMKTypeTag.CurrentImage.rawValue) {
                view.center = CGPoint.init(x: w / 2, y: h / 2)
                return view as? UIImageView
            }
            return UIImageView.init()*/
            return getProperty("imageContainer", initial: UIImageView.init())
        }
        set {
            setValue(newValue, forProperty: "imageContainer")
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
        if let toSet = getImage(ForTag: tag) {
            resetView(imageContainer)
            imageContainer = UIImageView.init(image: toSet)
            addSubview(imageContainer)
            imageContainer.center = CGPoint.init(x: w / 2, y: h / 2)
        }
    }
}
