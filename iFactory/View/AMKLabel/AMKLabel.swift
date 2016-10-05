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
        }
    }
    @IBInspectable dynamic var text: String {
        get {
            return getProperty("text", initial: "")
        }
        set {
            setValue(newValue, forProperty: "text")
            //encode()
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
        print("label move to superview")
    }
    override func didMoveToWindow() {
        print("label move to window")
        #if TARGET_INTERFACE_BUILDER
        
        if let _ = label {
            drawRect(frame)
        }
        #endif
    }
}