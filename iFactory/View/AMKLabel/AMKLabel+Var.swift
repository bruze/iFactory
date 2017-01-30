//
//  AMKLabel+Var.swift
//  iFactory
//
//  Created by Bruno Garelli on 10/31/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import UIKit
import AssociatedValues
extension AMKLabel {
    @IBOutlet weak var label: UILabel? {
        get {
            return getAssociatedValue(key: "label", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "label", object: self)
            label!.isHidden = true
        }
        /*didSet {
            //label?.enabled = false
            label!.hidden = true
            //text = label!.text!
            //setNilValueForKey("text")
            //setValue(text, forKey: "text")
            //drawRect(frame)
            /*let newLabel = (label?.copy() as? UILabel)!
             addSubview(newLabel)
             newLabel.center = center*/
            //let path = NSBundle.mainBundle().pathForResource(storeID, ofType: ".plist")
            // print(NSFileManager.defaultManager().
        }*/
    }
    dynamic var text: String {
        get {
            return getAssociatedValue(key: "text", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "text", object: self)
        }
    }
    dynamic var textColor: UIColor {
        get {
            return getAssociatedValue(key: "textColor", object: self, initialValue: UIColor.blue)
        }
        set {
            set(associatedValue: newValue, key: "textColor", object: self)
        }
    }
    dynamic var textFont: UIFont {
        get {
            return getAssociatedValue(key: "textFont", object: self, initialValue: UIFont.systemFont(ofSize: 16))
        }
        set {
            set(associatedValue: newValue, key: "textFont", object: self)
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
}
