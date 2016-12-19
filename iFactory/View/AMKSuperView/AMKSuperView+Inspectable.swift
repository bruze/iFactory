//
//  AMKSuperView+Inspectable.swift
//  iFactory
//
//  Created by Bruno Garelli on 11/7/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBInspectable var storeButtonID: String {
        get {
            return getProperty("storeButtonID", initial: "")
        }
        set {
            setValue(newValue, forProperty: "storeButtonID")
            encode()
        }
    }
    //MARK: Action on Touch
    @IBInspectable dynamic var touchAction: String {
        get {
            return getProperty("touchAction", initial: "")
        }
        set {
            setValue(newValue, forProperty: "touchAction")
        }
    }
    @IBOutlet var delegate: AnyObject? {
        get {
            return getProperty("delegate", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "delegate")
        }
    }
    override func encode() {
        let parsedData = ["": idleImage.imageAsset.debugDescription]
        print(parsedData)
    }
    override func decode(data: NSDictionary) {
        print()
    }
}
