//
//  AMKButton+Delegate.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import SwiftString

extension AMKButton {
    /*internal var actions: [String] {
        get {
            return getProperty("actions", initial: [])
        }
        set {
            setValue(newValue, forProperty: "actions")
        }
    }
    @IBInspectable var newAction: String {
        get {
            return self.newAction
        }
        set {
            if !actions.contains(newValue) {
                actions.append(newValue)
            } else {
                print(newValue.join(["Attempting to add "," action[delegate] more than once"]))
            }
        }
    }
    @IBInspectable var eraseAction: String {
        get {
            return self.eraseAction
        }
        set {
            if actions.contains(newValue) {
                actions.removeObject(newValue)
            } else {
                print(newValue.join(["Attempting to delete unexisting "," action[delegate]"]))
            }
        }
    }*/
    var actionBlocks: [() -> ()]? {
        get {
            return getProperty("actionBlocks", initial: [])
        }
        set {
            setValue(newValue, forProperty: "actionBlocks")
        }
    }
    @IBInspectable var touchAction: String {
        get {
            return getProperty("touchAction", initial: "")
        }
        set {
            setValue(newValue, forProperty: "touchAction")
        }
    }
    @IBInspectable var enabledAction: String {
        get {
            return getProperty("enabledAction", initial: "")
        }
        set {
            setValue(newValue, forProperty: "enabledAction")
        }
    }
    @IBInspectable var disabledAction: String {
        get {
            return getProperty("disabledAction", initial: "")
        }
        set {
            setValue(newValue, forProperty: "disabledAction")
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
    internal func delegatePerformTouch() {
        //if !touchAction.isEmpty {
            if actionBlocks?.count == 0 {
                if let executer = delegate as? UIViewController {
                    let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
                    executer.performSelector(aSelector, withObject: "")
                }
            } else {
                actionBlocks?.first!()
            }
        //}
    }
    internal func delegatePerformEnable() {
        if !enabledAction.isEmpty {
            if let executer = delegate as? UIViewController {
                let aSelector = Selector.init(extendedGraphemeClusterLiteral: enabledAction)
                executer.performSelector(aSelector, withObject: "")
            }
        }
    }
    internal func delegatePerformDisable() {
        if !disabledAction.isEmpty {
            if let executer = delegate as? UIViewController {
                let aSelector = Selector.init(extendedGraphemeClusterLiteral: disabledAction)
                executer.performSelector(aSelector, withObject: "")
            }
        }
    }
    internal func addBlock(block: () -> (), ForAction action: Int) {
        actionBlocks?.append(block)
    }
    //internal func delegatePerform() {
        /*for action in actions {
            if let executer = delegate as? UIViewController {
                let aSelector = Selector.init(extendedGraphemeClusterLiteral: action)
                if executer.respondsToSelector(aSelector) {
                    executer.performSelector(aSelector, withObject: " JAJAJAJAJAJAmorewinning4medumpoooo")
                    //executer.performSelector(aSelector)
                }
            }
        }*/
    //}
}
