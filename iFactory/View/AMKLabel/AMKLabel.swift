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
            encode()
        }
    }
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var route = NSMutableString()
    var timestamp = NSMutableString()
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string: "/Users/bgarelli/Git/iFactory/iFactory/iFactory/Base.lproj/Main.storyboard"))!)!
        parser.delegate = self
        parser.parse()
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
    //MARK:PARSER
    // didStartElement
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("marker")
        {
            elements = NSMutableDictionary()
            elements = [:]
            route = NSMutableString()
            route = ""
            timestamp = NSMutableString()
            timestamp = ""
        }
    }
    
    // foundCharacters
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("route") {
            route.appendString(string)
        } else if element.isEqualToString("timestamp") {
            timestamp.appendString(string)
        }
    }
    
    // didEndElement
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("marker") {
            if !route.isEqual(nil) {
                elements.setObject(route, forKey: "route")
            }
            if !timestamp.isEqual(nil) {
                elements.setObject(timestamp, forKey: "timestamp")
            }
            posts.addObject(elements)
        }
    }
    //MARK:OVERRIDE
    override func didMoveToSuperview() {
        print("label move to superview")
    }
    override func didMoveToWindow() {
        print("label move to window")
        #if TARGET_INTERFACE_BUILDER
        /*let parser = NSXMLParser.init(contentsOfURL: NSURL.init(fileURLWithPath: "/Users/bgarelli/Git/iFactory/iFactory/iFactory/Base.lproj/Main.storyboard"))*/
        /*beginParsing()
        print("The route is")
        let t = elements["route"]!
        print(t)
        print("The timestamp is")
        let u = elements["timestamp"]!
        print(u)*/
        if let _ = label {
            drawRect(frame)
        }
        #endif
    }
}