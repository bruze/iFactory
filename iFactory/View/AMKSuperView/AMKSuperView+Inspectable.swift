//
//  AMKSuperView+Inspectable.swift
//  iFactory
//
//  Created by Bruno Garelli on 11/7/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
extension AMKSuperView {
    @IBInspectable var storeButtonID: String {
        get {
            return getAssociatedValue(key: "storeButtonID", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "storeButtonID", object: self)
            encode()
        }
    }
    //MARK: Action on Touch
    @IBInspectable dynamic var touchAction: String {
        get {
            return getAssociatedValue(key: "touchAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "touchAction", object: self)
        }
    }
    @IBOutlet var delegate: AnyObject? {
        get {
            return getAssociatedValue(key: "delegate", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "delegate", object: self)
        }
    }
    override func encode() {
        let parsedData = ["": idleImage.imageAsset.debugDescription]
    }
    override func decode(_ data: NSDictionary) {
    }
}
