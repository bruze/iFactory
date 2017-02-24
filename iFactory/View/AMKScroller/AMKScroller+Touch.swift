//
//  AMKScroller+Touch.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/7/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKScroller {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let firstTouch = touches.first {
            scrollAnchor = firstTouch.location(in: self)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let firstTouch = touches.first {
            let movePoint = firstTouch.location(in: self)
            let deltaPoint = movePoint.substract(scrollAnchor)
            scrollSpeed = max(abs(deltaPoint.x) / w, abs(deltaPoint.y) / h)
            scroll(moves: movesFor(Translation: deltaPoint))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        /*if let firstTouch = touches.first {
            let movePoint = firstTouch.location(in: self)
            let deltaPoint = movePoint.substract(scrollAnchor)
            //print(deltaPoint)
        }*/
        let topBorder = scrollOffsets.y + bounceOffsets.y
        if topView.frame.y >= topEdge {
            scrolling.toggle()
            animate(duration: 0.1, animations: {
                /*_ = self.topView.frame.y - self.topEdge
                self.topView.frame.y = 0*/
                for view in self.subviews {
                    let diff = self.topView.frame.y - self.topEdge
                    if view == self.topView {
                        view.frame.y -= self.topView.y
                    } else {
                        view.frame.y -= diff
                    }
                    //print(view.frame)
                }
            }, completion: { (completed) in
                self.interpolateY(&self.topView, topBorder)
            })
        }
    }
    func interpolateY(_ view: inout UIView, _ d: CGFloat) {
        var view = view
        if abs(d) <= 5 {
            self.scrolling.toggle()
            //print(view.frame)
            view.frame.y = self.topEdge//scrollOffsets.y + bounceOffsets.y
        } else {
            animate(duration: 0.1, animations: { 
                view.frame.y += d
            }, completion: { (completed) in
                self.interpolateY(&view, -d/2)
            })
        }
    }
    func searchForViewOutOfBounds() -> UIView {
        
        return emptyView
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        print()
    }
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        print()
    }
}
