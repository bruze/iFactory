//
//  AMKSuperView.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import Foundation
import UIKit
@IBDesignable
class AMKSuperView: UIView {
    var kvoContext: UInt = 1
    override func didMoveToSuperview() {
        if superview != nil {
            /*centerInSuperView()
             superview!.layoutIfNeeded()
             setNeedsLayout()*/
        }
    }
    func handle(not: NSNotification) {
        print(not)
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        noti.addObserver(self, selector: #selector(handle), name: nil, object: nil)
        #if TARGET_INTERFACE_BUILDER
            if !storeLoaded && !storeID.isEmpty {
                label.storeID = storeID
                label.overrideStoredText = false
                addSubview(label)
                label.reloadAMKConfig()
                /*let path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Xcode/Overlays/amk/\(storeID).plist"
                if fileMan.fileExistsAtPath(path) {
                    let entityData = NSDictionary.init(contentsOfFile: path)
                    label.decode(entityData!)
                    addSubview(label)
                    label.reloadAMKConfig()
                    storeLoaded = true
                }*/
            }
            /*if let _ = label {
                drawRect(frame)
            }*/
        #else
            if !storeLoaded && !storeID.isEmpty {
                label.storeID = storeID
                label.overrideStoredText = false
                if let path = bundle.pathForResource(storeID.stringByAppendingString(".plist"), ofType: nil, inDirectory: "amk") {
                    let entityData = NSDictionary.init(contentsOfFile: path)
                    label.decode(entityData!)
                    addSubview(label)
                    label.reloadAMKConfig()
                    storeLoaded = true
                }
            }
        #endif
        
        /*if label != nil {
            label.drawRect(frame)
        }*/
        //label.drawCurves(frame)
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
        center = CGPoint.init(x: w / 2, y: h / 2)
        clipsToBounds = false
        #if !TARGET_INTERFACE_BUILDER
        addObserver(self, forKeyPath: "enabled", options: NSKeyValueObservingOptions.New, context: &kvoContext)
        addObserver(self, forKeyPath: "origin", options: NSKeyValueObservingOptions.New, context: &kvoContext)
        #endif
        //decode()
        //addSubview(imageContainer)
        //clipsToBounds = true
    }
    override func prepareForInterfaceBuilder() {
        /*if label != nil {
            //label.drawTextInRect(label.bounds)
            label.drawRect(frame)
        }*/
        //label.drawCurves(frame)
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        /*if label != nil {
            label.drawRect(rect)
        }*/
        //label.drawCurves(rect)
    }
}
