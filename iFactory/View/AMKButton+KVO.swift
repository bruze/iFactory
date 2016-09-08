//
//  AMKButton+KVO.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/7/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation

extension AMKButton {
    internal var observing: Bool {
        get {
            return getProperty("observing", initial: false)
        }
        set {
            setValue(newValue, forProperty: "observing")
        }
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &kvoContext {
            //print("Change at keyPath = \(keyPath) for \(object)")
            if keyPath == "enabled" {
                if let value = change?["new"]! as? Bool {
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