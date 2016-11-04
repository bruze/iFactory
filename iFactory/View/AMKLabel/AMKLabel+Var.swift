//
//  AMKLabel+Var.swift
//  iFactory
//
//  Created by Bruno Garelli on 10/31/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import UIKit

extension AMKLabel {
    @IBOutlet weak var label: UILabel? {
        get {
            return getProperty("label", initial: nil)
        }
        set {
            setValue(newValue, forProperty: "label")
            label!.hidden = true
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
            return getProperty("text", initial: "")
        }
        set {
            setValue(newValue, forProperty: "text")
        }
    }
    dynamic var textColor: UIColor {
        get {
            return getProperty("textColor", initial: UIColor.blueColor())
        }
        set {
            setValue(newValue, forProperty: "textColor")
        }
    }
    dynamic var textFont: UIFont {
        get {
            return getProperty("textFont", initial: UIFont.systemFontOfSize(16))
        }
        set {
            setValue(newValue, forProperty: "textFont")
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
}