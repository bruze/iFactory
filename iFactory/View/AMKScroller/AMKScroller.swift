//
//  AMKScroller.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/1/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import UIKit
@IBDesignable
class AMKScroller: UIView {
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
        /*center = CGPoint.init(x: w / 2, y: h / 2)*/
        clipsToBounds = true
        backgroundColor = UIColor.red
        //actions["default"] = defaultAction
        addGestureRecognizer(gesture)
    }
    func defaultAction(down: Bool) {
        var decreaser = CGFloat(-10)
        if down {
            decreaser = 10
        }
        let first = subviews.first!
        let last = subviews.last!
        if !(last.frame.y + decreaser < maxYSubviews) {
            canScrollDown = false
        } else if !(first.frame.y + decreaser > -maxYSubviews) {
            canScrollUp = false
        }
        if (down && !canScrollDown) || (!down && !canScrollUp) {
            return
        }
        for sv in subviews {
            var f = sv.frame
            let newY = f.y + decreaser
            f.y = newY
            /*animate(animations: {
                sv.frame = f
            })*/
            animate(animations: { 
                sv.frame = f
            }, completion: { (completed) in
                if completed {
                    self.canScrollDown = true
                    self.canScrollUp = true
                }
            })
        }
    }
    func didPan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        if translation.y > 0 {
            if !canScrollUp {
                return
            }
        } else {
            if !canScrollDown {
                return
            }
        }
        defaultAction(down: translation.y < 0)
    }
}
