//
//  AMKButton.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/5/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import PropertyExtensions

@IBDesignable
class AMKButton: UIView, PropertyExtensions {
    enum AMKTypeTag: Int {
        case Default       = -1
        case CurrentImage  =  7
        case ImageDefault  = 10
        case ImagePressed  = 11
        case ImageDisabled = 12
        case LabelDefault  = 13
    }
    internal var kvoContext: UInt = 1
    dynamic var enabled: Bool {
        get {
            return getProperty("enabled", initial: true)
        }
        set {
            setValue(newValue, forProperty: "enabled")
            if newValue {
                currentDefaultLabel?.alpha = 1.0
                if !enabledAction.isEmpty {
                    delegatePerformEnable()
                }
            } else {
                currentDefaultLabel?.alpha = 0.26
                if !disabledAction.isEmpty {
                    delegatePerformDisable()
                }
            }
        }
    }
    var images: [AMKTypeTag: UIImage] = [:]
    var currentImage: UIImageView? {
        get {
            if let view = viewWithTag(AMKTypeTag.CurrentImage.rawValue) {
                return view as? UIImageView
            }
            return nil
        }
    }
    var currentDefaultLabel: UILabel? {
        get {
            if let view = viewWithTag(AMKTypeTag.LabelDefault.rawValue) {
                return view as? UILabel
            }
            return nil
        }
    }
    @IBInspectable var defaultLabel: String = "" {
        didSet {
            resetView(currentDefaultLabel)
            if !defaultLabel.isEmpty {
                addLabelWith(Text: defaultLabel, AndOffset: CGPoint.zero)
            }
        }
    }
    @IBInspectable var defLabelXOffset: CGFloat = CGFloat.init() {
        didSet {
            if labelRelativeImage == 0 {
                currentDefaultLabel?.origin.x += defLabelXOffset
            } else {
                print(labelRelativeImage)
            }
        }
    }
    @IBInspectable var imageLeading: CGFloat = 10 {
        didSet {
            currentImage?.origin.x += imageLeading
        }
    }
    @IBInspectable var labelRelativeImage: CGFloat = 5 {
        didSet {
            if let image = currentImage {
                currentDefaultLabel?.origin.x = image.origin.x + image.w + labelRelativeImage
            }
        }
    }
    @IBInspectable var storeID: String {
        get {
            return getProperty("storeID", initial: "")
        }
        set {
            setValue(newValue, forProperty: "storeID")
            //encode()
            //decode()
        }
    }
    /*override func willMoveToSuperview(newSuperview: UIView?) {
        //encode()
        print("")
    }
    override func didMoveToWindow() {
        print("window Added")
    }*/
    override func didMoveToSuperview() {
        if superview != nil {
            centerInSuperView()
            superview!.layoutIfNeeded()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.initialize()
    }
    func initialize() {
    }
}
