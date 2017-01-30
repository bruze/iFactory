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
import AssociatedValues

//@IBDesignable
class AMKCarousel: UIView {
    var pagingEnabled = true
    var isSmallScreen = false
    @IBInspectable override var storeID: String {
        get {
            return getAssociatedValue(key: "storeID", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "storeID", object: self)
        }
    }
    @IBInspectable var specialSize: Bool {
        get {
            return getAssociatedValue(key: "specialSize", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "specialSize", object: self)
        }
    }
    @IBInspectable var verticalScroll: Bool {
        get {
            return getAssociatedValue(key: "verticalScroll", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "verticalScroll", object: self)
        }
    }
    @IBInspectable var offsets: CGPoint {
        get {
            return getAssociatedValue(key: "offsets", object: self, initialValue: CGPoint.zero)
        }
        set {
            set(associatedValue: newValue, key: "offsets", object: self)
        }
    }
    @IBOutlet var views: [UIView]? {
        didSet {
            viewPointsIndicator = views!.count
            scrollView.viewPointsIndicator = viewPointsIndicator
            scrollView.reloadDataWithInitialIndex(initialIndex: lastScrollIndicator)
            addSubview(scrollView)
            setNeedsDisplay()
        }
    }
    var lastScrollIndicator = 0
    internal var scrollSetupDone = false
    internal var offsetSetupDone = false
    internal var lastScrollDirection: ScrollDirection = .ScrollDirectionPrev
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
        backgroundColor = UIColor.clear
    }
    override func didMoveToSuperview() {
        if !scrollSetupDone {
            setupScroll()
            addSubview(scrollView)
            //scrollView.centerInSuperView()
            //scrollView.setNeedsLayout()
            //setNeedsLayout()
        }
    }
    override func didAddSubview(_ subview: UIView) {
        let screenSize = UIScreen.main.bounds
        if screenSize.height >= 1024 && specialSize {
            if (views?.count)! > 0 && !offsetSetupDone {
                var daFrame = subview.frame
                daFrame.size.height -= 30
                //daFrame.size.width -= 30
                if daFrame.height < 400 {
                    daFrame.y -= 80
                } else if Int(daFrame.height) == 477 {
                    daFrame.y -= 100
                } else {
                    //daFrame.x -= 180
                    daFrame.y -= 40
                }
                daFrame.x += 180
                subview.frame = daFrame
                offsetSetupDone = true
            }
        } else {
            if screenSize.height < 667 {
                if (views?.count)! > 0 && !offsetSetupDone {
                    var daFrame = subview.frame
                    var offsetY = CGFloat(40)
                    if Int(daFrame.height) != 211 {
                        if daFrame.height > 200 {
                            offsetY = 25
                        }
                        daFrame.x -= 20
                        daFrame.y -= offsetY
                        subview.frame = daFrame
                    } else {
                        //daFrame.x -= 10
                        //daFrame.size.width += 10
                        daFrame.y += 20
                        subview.frame = daFrame
                    }
                    offsetSetupDone = true
                }
            } else {
                subview.sizeThatFits(bounds.size)
                var center = self.centerX
                if (views?.count)! > 0 && !offsetSetupDone {
                    center += offsets.x
                    var nFrame = subview.frame
                    //let diff = bounds.size.width - nFrame.size.width
                    if specialSize && nFrame.size.height != 248 {
                        nFrame.y -= 30
                    }
                    nFrame.size.width -= offsets.x * 2
                    subview.frame = nFrame
                    offsetSetupDone = true
                }
                subview.centerX = center
            }
        }
        subview.clipsToBounds = true
    }
}
