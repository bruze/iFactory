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
class AMKButton: UIView {
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
    @IBInspectable var labelRelativeImage: CGFloat = 5 {
        didSet {
            /*if let image = currentImage {
                currentDefaultLabel?.origin.x = image.origin.x + image.w + labelRelativeImage
            }*/
        }
    }
    /*@IBInspectable override var storeID: String {
        get {
            return getProperty("storeID", initial: "")
        }
        set {
            setValue(newValue, forProperty: "storeID")
            //encode()
            //decode()
        }
    }*/
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
            setNeedsLayout()
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
        self.init(frame: CGRect.zero)
        self.initialize()
    }
    func initialize() {
        //decode()
        addSubview(imageContainer)
    }
}
