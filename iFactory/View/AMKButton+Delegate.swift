//
//  AMKButton+Delegate.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/6/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
import EZSwiftExtensions
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
            return getAssociatedValue(key: "actionBlocks", object: self, initialValue: [])
        }
        set {
            set(associatedValue: newValue, key: "actionBlocks", object: self)
        }
    }
    @IBInspectable var touchAction: String {
        get {
            return getAssociatedValue(key: "touchAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "touchAction", object: self)
        }
    }
    @IBInspectable var enabledAction: String {
        get {
            return getAssociatedValue(key: "enabledAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "enabledAction", object: self)
        }
    }
    @IBInspectable var disabledAction: String {
        get {
            return getAssociatedValue(key: "disabledAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "disabledAction", object: self)
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
    internal func delegatePerformTouch() {
        //if !touchAction.isEmpty {
            if actionBlocks?.count == 0 {
                guard !touchAction.isEmpty else {
                    return
                }
                let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
                if let executer = delegate as? UIViewController {
                    if executer.responds(to: aSelector) {
                        executer.perform(aSelector, with: "")
                    }
                } else if let executer = delegate as? ViewController {
                    if executer.responds(to: aSelector) {
                        executer.perform(aSelector, with: "")
                    }
                } else if let executer = ez.topMostVC {
                    if executer.responds(to: aSelector) {
                        executer.performSelector(inBackground: aSelector, with: "")
                    }
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
                executer.perform(aSelector, with: "")
            }
        }
    }
    internal func delegatePerformDisable() {
        if !disabledAction.isEmpty {
            if let executer = delegate as? UIViewController {
                let aSelector = Selector.init(extendedGraphemeClusterLiteral: disabledAction)
                executer.perform(aSelector, with: "")
            }
        }
    }
    internal func addBlock(_ block: @escaping () -> (), ForAction action: Int) {
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
