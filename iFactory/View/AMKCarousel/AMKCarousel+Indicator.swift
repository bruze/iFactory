//
//  AMKCarousel+Indicator.swift
//  e2e
//
//  Created by Bruno Garelli on 10/10/16.
//  Copyright © 2016 Altimetrik. All rights reserved.
//

import AssociatedValues
extension AMKCarousel {
    @IBInspectable var showIndicator: Bool {
        get {
            return getAssociatedValue(key: "showIndicator", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "showIndicator", object: self)
        }
    }
    @IBInspectable var indicatorColor: UIColor {
        get {
            return getAssociatedValue(key: "indicatorColor", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "indicatorColor", object: self)
        }
    }
    var viewPointsIndicator: Int {
        get {
            return getAssociatedValue(key: "viewPointsIndicator", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "viewPointsIndicator", object: self)
        }
    }
    var currentIndicator: Int {
        get {
            return getAssociatedValue(key: "currentIndicator", object: self, initialValue: 1)
        }
        set {
            set(associatedValue: newValue, key: "currentIndicator", object: self)
        }
    }
    var indicatorJustUpdated: Bool {
        get {
            return getAssociatedValue(key: "indicatorJustUpdated", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "indicatorJustUpdated", object: self)
        }
    }
}
