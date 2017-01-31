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
    func handle(_ not: Notification) {
        print(not)
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
}
