//
//  AMKCarousel.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/7/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

//import LTInfiniteScrollView
import UIKit
import EZSwiftExtensions
import PropertyExtensions

@IBDesignable
class AMKCarousel: UIView {
    @IBInspectable override var storeID: String {
        get {
            return getProperty("storeID", initial: "")
        }
        set {
            setValue(newValue, forProperty: "storeID")
        }
    }
    @IBOutlet var views: [UIView]? {
        didSet {
            scrollView.reloadDataWithInitialIndex(0)
            addSubview(scrollView)
            setNeedsLayout()
        }
    }
    internal var scrollSetupDone = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        self.initialize()
    }
    func initialize() {
    }
    override func didMoveToSuperview() {
        if !scrollSetupDone {
            setupScroll()
            addSubview(scrollView)
            //scrollView.centerInSuperView()
            //scrollView.setNeedsLayout()
            setNeedsLayout()
        }
    }
    override func didAddSubview(subview: UIView) {
        //subview.centerInSuperView()
        setNeedsLayout()
    }
}
