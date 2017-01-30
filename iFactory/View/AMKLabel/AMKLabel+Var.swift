//
//  AMKLabel+Var.swift
//  iFactory
//
//  Created by Bruno Garelli on 10/31/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import EZSwiftExtensions
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
    func getPointFromStringOffsets(data: String) -> CGPoint {
        let components = data.components(separatedBy: "|")
        let result = CGPoint.init(x: CGFloat(components[0].toFloat()!), y: CGFloat(components[1].toFloat()!))
        return result
    }
    @IBInspectable dynamic var offsetsText: String {
        get {
            return getAssociatedValue(key: "offsetsText", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "offsetsText", object: self)
            textOffset = getPointFromStringOffsets(data: offsetsText)
        }
    }
    dynamic var textOffset: CGPoint {
        get {
            return getAssociatedValue(key: "textOffset", object: self, initialValue: CGPoint.zero)
        }
        set {
            set(associatedValue: newValue, key: "textOffset", object: self)
        }
    }
    dynamic var textSize: CGFloat {
        get {
            return getAssociatedValue(key: "textSize", object: self, initialValue: 10)
        }
        set {
            set(associatedValue: newValue, key: "textSize", object: self)
            let otherFont = textFont.withSize(newValue)
            self.textFont = otherFont
        }
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
