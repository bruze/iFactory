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
    override public var intrinsicContentSize: CGSize {
        let standardSize = frame.size
        let scale = UIScreen.main.bounds.width / 375.0
        let finalSize = CGSize.init(width: standardSize.width * scale, height: standardSize.height)
        return finalSize
    }
    override func didMoveToSuperview() {
        if superview != nil {
            /*centerInSuperView()
             superview!.layoutIfNeeded()
             setNeedsLayout()*/
        }
    }
    func handle(_ not: Notification) {
        print(not)
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        //noti.addObserver(self, selector: #selector(handle), name: nil, object: nil)
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
                if let path = bundle.path(forResource: storeID + ".plist", ofType: nil, inDirectory: "amk") {
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
        addObserver(self, forKeyPath: "enabled", options: NSKeyValueObservingOptions.new, context: &kvoContext)
        addObserver(self, forKeyPath: "origin", options: NSKeyValueObservingOptions.new, context: &kvoContext)
        #endif
        //decode()
        //addSubview(imageContainer)
        //clipsToBounds = true
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        settleImageView()
    }
    override func prepareForInterfaceBuilder() {
        /*if label != nil {
            //label.drawTextInRect(label.bounds)
            label.drawRect(frame)
        }*/
        //label.drawCurves(frame)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        /*if label != nil {
            label.drawRect(rect)
        }*/
        //label.drawCurves(rect)
    }
}
