//
//  AMKLabel.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/28/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
@IBDesignable
class AMKLabel: UIView, NSXMLParserDelegate {
    //var kvoContext: UInt = 1
    @IBInspectable dynamic var curve: Bool {
        get {
            return getProperty("curve", initial: false)
        }
        set {
            setValue(newValue, forProperty: "curve")
        }
    }
    @IBInspectable dynamic var curveRadius: CGFloat {
        get {
            return getProperty("curveRadius", initial: 1)
        }
        set {
            setValue(newValue, forProperty: "curveRadius")
        }
    }
    @IBInspectable dynamic var curveAngle: CGFloat {
        get {
            return getProperty("curveAngle", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "curveAngle")
        }
    }
    @IBInspectable dynamic var curveClockwise: Bool {
        get {
            return getProperty("curveClockwise", initial: true)
        }
        set {
            setValue(newValue, forProperty: "curveClockwise")
        }
    }
    @IBOutlet weak var label: UILabel? {
        didSet {
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
        }
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    convenience init() {
        self.init(frame: CGRect.zero)
        self.initialize()
    }
    func initialize() {
        //UIView.animateWithDuration(10, animations: {self.origin = CGPoint.init(x: self.origin.x + 200, y: self.origin.y + 50)})
        /*center = CGPoint.init(x: w / 2, y: h / 2)
        clipsToBounds = false
        #if !TARGET_INTERFACE_BUILDER
            addObserver(self, forKeyPath: "enabled", options: NSKeyValueObservingOptions.New, context: &kvoContext)
            addObserver(self, forKeyPath: "origin", options: NSKeyValueObservingOptions.New, context: &kvoContext)
        #endif*/
    }
    
    //MARK:OVERRIDE
    override func didMoveToSuperview() {
        //print("label move to superview")
        //print(storeID)
    }
    override func didMoveToWindow() {
        //print("label move to window")
        #if TARGET_INTERFACE_BUILDER
            if !storeLoaded {
                let path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Xcode/Overlays/amk/\(storeID).plist"
                if fileMan.fileExistsAtPath(path) {
                    let entityData = NSDictionary.init(contentsOfFile: path)
                    decode(entityData!)
                    storeLoaded = true
                }
            }
            if let _ = label {
                drawRect(frame)
            }
        #else
            if !storeLoaded {
                if let path = bundle.pathForResource(storeID.stringByAppendingString(".plist"), ofType: nil, inDirectory: "amk") {
                    let entityData = NSDictionary.init(contentsOfFile: path)
                    decode(entityData!)
                    storeLoaded = true
                }
            }
        #endif
    }
    override func decode(data: NSDictionary) {
        text = (data["text"] as? String)!
        textColor = colorFromStoredInfo((data["textColor"] as? String)!)
        setNeedsDisplay()
    }
    func colorFromStoredInfo(infoColor: String) -> UIColor {
        var result = UIColor.clearColor()
        let components = infoColor.componentsSeparatedByString(" ").filter { (component) -> Bool in
            return component.isNumber()
        }
        if components.count == 4 {
            result = UIColor.init(red: components[0].toFloat()!.cg(), green: components[1].toFloat()!.cg(), blue: components[2].toFloat()!.cg(), alpha: components[3].toFloat()!.cg())
        } else {
            let meKnow = true
        }
        return result
    }
}

extension Float {
    func cg() -> CGFloat {
        return CGFloat(self)
    }
}
