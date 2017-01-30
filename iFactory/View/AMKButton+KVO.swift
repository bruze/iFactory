//
//  AMKButton+KVO.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/7/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import AssociatedValues
extension AMKButton {
    internal var observing: Bool {
        get {
            return getAssociatedValue(key: "observing", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "observing", object: self)
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &kvoContext {
            //print("Change at keyPath = \(keyPath) for \(object)")
            if keyPath == "enabled" {
                if let value = change?[.newKey]! as? Bool {
                    if value {
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
        }
    }
}
