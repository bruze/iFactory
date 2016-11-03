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
    override func intrinsicContentSize() -> CGSize {
        return frame.size
    }
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
    func reloadAMKConfig() {
        if let path = bundle.pathForResource(storeID.stringByAppendingString(".plist"), ofType: nil, inDirectory: "amk") {
            let entityData = NSDictionary.init(contentsOfFile: path)
            decode(entityData!)
        }
    }
    override func decode(data: NSDictionary) {
        text = data["text"]!.str()
        textColor = overrideStoredTextColor ? overrideTextColor : colorFromStoredInfo(data["textColor"]!.str())
        let fontName = data["fontName"]!.str()
        //let family = UIFont.fontNamesForFamilyName(fontName)
        textFont = fontFromStoredInfo(fontName)//UIFont.init(name: fontName + "- Bold", size: 16)!
        setNeedsDisplay()
    }
    func colorFromStoredInfo(infoColor: String) -> UIColor {
        var result = UIColor.clearColor()
        let components = infoColor.componentsSeparatedByString(" ")
        let filtered = components.filter { (component) -> Bool in
            return component.isNumber()
        }
        if filtered.count == 4 {
            result = UIColor.init(red: filtered[0].toFloat()!.cg(), green: filtered[1].toFloat()!.cg(), blue: filtered[2].toFloat()!.cg(), alpha: filtered[3].toFloat()!.cg())
        } else {
            let selectorName = components.last!
            let selector = NSSelectorFromString(selectorName)
            if UIColor.respondsToSelector(selector) {
                if let posibleColor = UIColor.performSelector(selector).takeRetainedValue() as? UIColor {
                    result = posibleColor
                }
            }
        }
        return result
    }
    func fontFromStoredInfo(infoFont: String) -> UIFont {
        let tTextSize = overrideStoredTextSize ? overrideTextSize : 16
        var result = UIFont.systemFontOfSize(tTextSize)
        let italicSystemResult = UIFont.italicSystemFontOfSize(tTextSize)
        let boldSystemResult = UIFont.boldSystemFontOfSize(tTextSize)
        
        var components = infoFont.componentsSeparatedByString(" ")
        var tryName = ""
        
        var lastComponent: [String] = []
        
        if components.count == 1 {
            lastComponent = components
        } else {
            lastComponent = [components.popLast()!]
        }
        
        let firstIsSystemCheck = components.count > 0 ? components.first! == "System" : false
        if lastComponent.flatString() != "System" && !firstIsSystemCheck {
            let flatString = components.flatString(" ")
            var family = UIFont.fontNamesForFamilyName(flatString)
            while family.count == 0 {
                lastComponent.insertAsFirst(components.popLast()!)
                let flatString = components.flatString()
                family = UIFont.fontNamesForFamilyName(flatString)
            }
            let filtered = family.filter { (comp) -> Bool in
                let sComponents = comp.componentsSeparatedByString("-")
                return sComponents.last! == lastComponent.flatString(" ")
            }
            if filtered.count > 0 {
                tryName = filtered.first!
            } else {
                tryName = family.first!
            }
            
            result = UIFont.init(name: tryName, size: overrideStoredTextSize ? overrideTextSize : 16)!
        } else if firstIsSystemCheck {
            if lastComponent.flatString() == "Bold" {
                result = boldSystemResult
            } else if lastComponent.flatString() == "Italic" {
                result = italicSystemResult
            }
        }
        
        return result
    }
}

extension CollectionType where Generator.Element == String {
    func flatString(separator: String = "") -> String {
        var result = ""
        self.forEach { (component) in
            result.appendContentsOf(component)
            if self.indexOf(component)?.successor() != self.endIndex {
                result.appendContentsOf(separator)
            }
        }
        return result
    }
}

extension NSObject {
    func str() -> String {
        return String(self)
    }
}

extension Float {
    func cg() -> CGFloat {
        return CGFloat(self)
    }
}
