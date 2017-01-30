//
//  AMKSuperView+KVO.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import AssociatedValues
extension AMKSuperView {
    /*dynamic var kvoContext: UInt {
        get {
            return getProperty("kvoContext", initial: 1)
        }
        set {
            setValue(newValue, forProperty: "kvoContext")
        }
    }*/
    @IBInspectable var enabled: Bool {
        get {
            return getAssociatedValue(key: "enabled", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "enabled", object: self)
            if newValue {
                /*currentDefaultLabel?.alpha = 1.0
                if !enabledAction.isEmpty {
                    delegatePerformEnable()
                }*/
            } else {
                /*currentDefaultLabel?.alpha = 0.26
                if !disabledAction.isEmpty {
                    delegatePerformDisable()
                }*/
            }
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &kvoContext {
            //print("Change at keyPath = \(keyPath) for \(object)")
            if keyPath == "enabled" {
                if let value = change?[.newKey]! as? Bool {
                    /*if value {
                        currentDefaultLabel?.alpha = 1.0
                        if !enabledAction.isEmpty {
                            delegatePerformEnable()
                        }
                    } else {
                        currentDefaultLabel?.alpha = 0.26
                        if !disabledAction.isEmpty {
                            delegatePerformDisable()
                        }
                    }*/
                }
            }
        }
    }
}
