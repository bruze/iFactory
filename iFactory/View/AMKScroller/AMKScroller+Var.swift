//
//  AMKScroller+Var.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/1/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import AssociatedValues
extension AMKScroller {
    @IBInspectable var doAction: String {
        /*get {
            return getAssociatedValue(key: "doAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "doAction", object: self)
            actions["default"]!()
        }*/
        get {
            return ""
        }
        set {
            //actions["default"]!()
        }
    }
    @IBInspectable var scrollOffset: CGFloat {
        get {
            return getAssociatedValue(key: "scrollOffset", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "scrollOffset", object: self)
        }
    }
    var actions: [String: () -> ()] {
        get {
            return getAssociatedValue(key: "actions", object: self, initialValue: [:])
        }
        set {
            set(associatedValue: newValue, key: "actions", object: self)
        }
    }
    var gesture: UIPanGestureRecognizer {
        get {
            return getAssociatedValue(key: "gesture", object: self, initialValue: UIPanGestureRecognizer.init(target: self, action: #selector(didPan)))
        }
        set {
            set(associatedValue: newValue, key: "gesture", object: self)
        }
    }
    var maxYSubviews: CGFloat {
        get {
            return getAssociatedValue(key: "maxYSubviews", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "maxYSubviews", object: self)
        }
    }
    var canScrollUp: Bool {
        get {
            return getAssociatedValue(key: "canScrollUp", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "canScrollUp", object: self)
        }
    }
    var canScrollDown: Bool {
        get {
            return getAssociatedValue(key: "canScrollDown", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "canScrollDown", object: self)
        }
    }
}
