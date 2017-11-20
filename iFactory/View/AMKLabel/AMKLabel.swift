//
//  AMKLabel.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/28/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import EZSwiftExtensions
@IBDesignable
class AMKLabel: UIView, XMLParserDelegate {
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
        backgroundColor = UIColor.clear
    }
    
    //MARK:OVERRIDE
    override var intrinsicContentSize : CGSize {
        return frame.size
    }
    /*override func didMoveToSuperview() {
    }*/
    override func didMoveToWindow() {
        /*#if TARGET_INTERFACE_BUILDER
            if !storeLoaded {
                /*let path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Xcode/Overlays/amk/\(storeID).plist"*/
                let path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Xcode/Overlays/amk/" + "fontDescription1" + ".plist"
                if fileMan.fileExistsAtPath(path) {
                    let entityData = NSDictionary.init(contentsOfFile: path)
                    decode(entityData!)
                    storeLoaded = true
                }
            }
            /*if let _ = label {
                drawRect(frame)
            }*/
        #else*/
            if !storeLoaded {
                if let path = bundle.path(forResource: storeID + ".plist", ofType: nil, inDirectory: "amk") {
                    let entityData = NSDictionary.init(contentsOfFile: path)
                    decode(entityData!)
                    storeLoaded = true
                }
            }
        //#endif
    }
    func reloadAMKConfig() {
        if let path = bundle.path(forResource: storeID + ".plist", ofType: nil, inDirectory: "amk") {
            let entityData = NSDictionary.init(contentsOfFile: path)
            decode(entityData!)
        }
    }
    func initialConfig() {
        /*if mutateOnTouch && storeID == mutateStoreID {
            storeID = backStoreID
            reloadAMKConfig()
        }*/
    }
    override func decode(_ data: NSDictionary) {
        //text = (data["text"]! as AnyObject).str()
        if let rawData = data["textColor"] {
            textColor = overrideStoredTextColor ? overrideTextColor : colorFromStoredInfo(any2(obj: rawData, cast2: String.self))
        } else {
            textColor = overrideStoredTextColor ? overrideTextColor : colorFromStoredInfoDict(data)
        }
        /*textColor = overrideStoredTextColor ? overrideTextColor : colorFromStoredInfo((data["textColor"]! as AnyObject).str())*/
        
        var fontName = "System"
        if let rawName = data["fontName"] {
            fontName = any2(obj: rawName, cast2: String.self)
        } else {
            if let rawName = data["name"] {
                fontName = any2(obj: rawName, cast2: String.self)
            }
        }
        //let family = UIFont.fontNamesForFamilyName(fontName)
        textFont = fontFromStoredInfo(fontName)//UIFont.init(name: fontName + "- Bold", size: 16)!
        //setNeedsDisplay()
    }
    func colorFromStoredInfoDict(_ info: NSDictionary) -> UIColor {
        /*return UIColor.init(r: any2(obj: info["red"]!, cast2: NSString.self).floatValue.cg(), g: any2(obj: info["green"]!, cast2: NSString.self).floatValue.cg(), b: any2(obj: info["blue"]!, cast2: NSString.self).floatValue.cg(), a: any2(obj: info["alpha"]!, cast2: NSString.self).floatValue.cg())*/
        let unsaf = UnsafeMutablePointer<CGFloat>.allocate(capacity: 4)
        unsaf[0] = CGFloat((info["red"] as! String).toFloat()!.cg())
        unsaf[1] = CGFloat((info["green"] as! String).toFloat()!.cg())
        unsaf[2] = CGFloat((info["blue"] as! String).toFloat()!.cg())
        unsaf[3] = CGFloat((info["alpha"] as! String).toFloat()!.cg())
        return UIColor.init(red: unsaf[0], green: unsaf[1], blue: unsaf[2], alpha: unsaf[3])
    }
    func colorFromStoredInfo(_ infoColor: String) -> UIColor {
        var result = UIColor.clear
        let components = infoColor.components(separatedBy: " ")
        let filtered = components.filter { (component) -> Bool in
            return component.isNumber()
        }
        if filtered.count == 4 {
            result = UIColor.init(red: filtered[0].toFloat()!.cg(), green: filtered[1].toFloat()!.cg(), blue: filtered[2].toFloat()!.cg(), alpha: filtered[3].toFloat()!.cg())
        } else {
            let selectorName = components.last!
            let selector = NSSelectorFromString(selectorName)
            if UIColor.responds(to: selector) {
                if let posibleColor = UIColor.perform(selector).takeRetainedValue() as? UIColor {
                    result = posibleColor
                }
            }
        }
        return result
    }
    func obtenerFamiliaFuente(_ chequeando: inout [String], componentes: inout [String]) -> String {
        let flatted = chequeando.flatString(" ")
        /*for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }*/
        let fonts = UIFont.fontNames(forFamilyName: flatted)
        if fonts.count > 0 {
            return flatted
        } else {
            if componentes.count > 0 {
                chequeando.append(componentes.removeFirst())
                return obtenerFamiliaFuente(&chequeando, componentes: &componentes)
            } else {
                return ""
            }
        }
    }
    func fontFromStoredInfo(_ infoFont: String) -> UIFont {
        let tTextSize = overrideStoredTextSize ? overrideTextSize : 16
        let systemResult = UIFont.systemFont(ofSize: tTextSize) // and default result
        if infoFont.contains("System") {
            let italicSystemResult = UIFont.italicSystemFont(ofSize: tTextSize)
            let boldSystemResult = UIFont.boldSystemFont(ofSize: tTextSize)
            
            let components = infoFont.components(separatedBy: " ")
            if components.count == 1 {
                return systemResult
            } else {
                let lastComponent = components.last
                if lastComponent == "Bold" {
                    return boldSystemResult
                } else if lastComponent == "Italic" {
                    return italicSystemResult
                }
            }
        } else {
            let components = infoFont.components(separatedBy: " ")
            for str in UIFont.familyNames {
                var maxCoincidence = 0
                var storeMatches: [(Int, String)] = []
                for comp in UIFont.fontNames(forFamilyName: str) {
                    var coincidences = 0
                    let lower1 = infoFont.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").lowercased()
                    let lower2 = comp.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").lowercased()
                    if lower1 == lower2 {
                        return UIFont.init(name: comp, size: overrideStoredTextSize ? overrideTextSize : 16)!
                    } else {
                        for anotherComp in components {
                            if comp.contains(anotherComp) {
                                coincidences += 1
                            }
                        }
                        if coincidences > maxCoincidence {
                            storeMatches.append((coincidences, comp))
                            maxCoincidence = coincidences
                        }
                    }
                    if let resultFont = storeMatches/*.sorted(by: { (obj, obj2) -> Bool in
                        if obj.0 == obj2.0 {
                            return obj.1.length > obj2.1.length
                        } else {
                            return obj.0 > obj2.0
                        }
                    })*/.first {
                        return UIFont.init(name: resultFont.1, size: overrideStoredTextSize ? overrideTextSize : 16)!
                    }
                    /*if lower1 == lower2  {
                        found = comp
                    } else if lower1.contains(lower2) {
                        if lower2.length > found.length {
                            found = comp
                            coincidences += 1
                        }
                    }*/
                    /*if infoFont.contains(comp) {
                        coincidences += 1
                        found += comp + "+"
                        //print(str)
                    }*/
                }
                
            }
            /*if !found.isEmpty {
                for comp in infoFont.lowercased().components(separatedBy: "-") {
                    if found.contains(comp) {
                        print(comp)
                    }
                }
            } else {
               print()
            }*/
            /*var checking = [components.removeFirst()]
            let familyName = obtenerFamiliaFuente(&checking, componentes: &components)
            if familyName.isEmpty {
                return systemResult
            } else {
                let family = UIFont.fontNames(forFamilyName: familyName)
                if family.count == 1 {
                    return UIFont.init(name: family.first!, size: overrideStoredTextSize ? overrideTextSize : 16)!
                } else {
                    let filtered = family.filter { (comp) -> Bool in
                        let sComponents = comp.components(separatedBy: "-")
                        return sComponents.last! == components.flatString() || sComponents.last! == components.flatString(" ")
                    }
                    if filtered.count == 1 {
                        return UIFont.init(name: filtered.first!, size: overrideStoredTextSize ? overrideTextSize : 16)!
                    } else {
                        return systemResult
                    }
                }
            }*/
        }
        return systemResult
    }
    internal func delegatePerformTouch() {
        guard !touchAction.isEmpty else {
            return
        }
        if let executer = delegate as? UIViewController {
            let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
            if executer.responds(to: aSelector) {
                executer.perform(aSelector, with: "")
            }
        } else if let executer = ez.topMostVC {
            let aSelector = Selector.init(extendedGraphemeClusterLiteral: touchAction)
            if executer.responds(to: aSelector) {
                executer.performSelector(inBackground: aSelector, with: "")
            }
        }
    }
}

extension Collection where Iterator.Element == String {
    func flatString(_ separator: String = "") -> String {
        var result = ""
        self.forEach { (component) in
            result.append(component)
            if self.index(of: component) != self.endIndex {
                result.append(separator)
            }
        }
        return result
    }
}

extension NSObject {
    func str() -> String {
        return String(describing: self)
    }
}

extension Float {
    func cg() -> CGFloat {
        return CGFloat(self)
    }
}
