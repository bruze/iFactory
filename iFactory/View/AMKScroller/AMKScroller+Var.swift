//
//  AMKScroller+Var.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/1/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import AssociatedValues
typealias ScrollAllowed = [Direction: Bool]
internal let defaultScrollAllowed: ScrollAllowed = [
    .left: true,
    .right: true,
    .up: true,
    .down: true
    ]
internal let ScrollOperations: [Direction: (_ view: AMKScroller,_ subview: UIView,_ offset: CGFloat,_ speed: CGFloat)->()] =
    [.left: {view,subview,off,speed in
            let offset = off / speed
            var setValue = subview.frame.x - offset
            if view.rightView.x + view.rightView.w < view.rightEdge {
                //setValue = subview.frame.x - 0.25
            }
            subview.frame.x = setValue
            },
     .right:{view,subview,off,speed in
            let offset = off / speed
            var setValue = subview.frame.x + offset
            if view.leftView.x >= view.leftEdge {
                setValue = subview.frame.x + 0.25
            }
            subview.frame.x = setValue
            },
     .up:   {view,subview,off,speed in
            let offset = off / speed
            var setValue = subview.frame.y - offset
            if view.botView.y + view.botView.h < view.botEdge {
                setValue = subview.frame.y - 0.25
            }
            subview.frame.y = setValue
            },
     .down: {view,subview,off,speed in
            let offset = off / speed
            var setValue = subview.frame.y + offset
            if view.topView.y >= view.topEdge {
                setValue = subview.frame.y + 0.25
            }
            subview.frame.y = setValue
            }]
internal let ScrollModeOperators: [ScrollMode: (_ view: AMKScroller, _ moves: [Direction])->ScrollAllowed] = [
    .normalize: {view,moves in
        var result = defaultScrollAllowed
        let first = view.topView
        let last = view.botView
        if first.frame.y >= /*0 + view.scrollOffsets.y + view.bounceOffsets.y*/view.topBorder {
            result[.down] = false
        } else if last.frame.y + last.size.height <= /*view.size.height - view.scrollOffsets.y - view.bounceOffsets.h*/view.botBorder {
            result[.up] = false
        }
        let left = view.leftView
        let right = view.rightView
        if right.frame.x <= /*0 - view.scrollOffsets.x - view.bounceOffsets.x*/view.leftBorder {
            result[.left] = false
        } else if left.x + left.w > /*view.w + view.scrollOffsets.w + view.bounceOffsets.w*/view.rightBorder {
            result[.right] = false
        }
        return result},
    .customOffset: {view,moves in
        var result = defaultScrollAllowed
        var decreaser = CGFloat(-10)
        if moves.contains(.down) {
            decreaser = 10
        }
        let first = view.subviews.first!
        let last = view.subviews.last!
        if !(last.frame.y + decreaser < view.maxYSubviews) {
            result[.down] = false
        } else if !(first.frame.y + decreaser > -view.maxYSubviews) {
            result[.up] = false
        }
        return result},
    .autoOffset: {_ in return [:]}]
extension AMKScroller {
    //MARK: Edges
    var topEdge: CGFloat {
        get {
            return scrollOffsets.y
        }
    }
    var botEdge: CGFloat {
        get {
            return size.height - scrollOffsets.y
        }
    }
    var leftEdge: CGFloat {
        get {
            return -scrollOffsets.x
        }
    }
    var rightEdge: CGFloat {
        get {
            return w + scrollOffsets.w
        }
    }
    //MARK: Borders
    var topBorder: CGFloat {
        get {
            return scrollOffsets.y + bounceOffsets.y
        }
    }
    var botBorder: CGFloat {
        get {
            return size.height - scrollOffsets.y - bounceOffsets.h
        }
    }
    var leftBorder: CGFloat {
        get {
            return -scrollOffsets.x + -bounceOffsets.x
        }
    }
    var rightBorder: CGFloat {
        get {
            return w + scrollOffsets.w + bounceOffsets.w
        }
    }
    //MARK: Subviews
    var topView: UIView {
        get {
            return getAssociatedValue(key: "topView", object: self, initialValue: emptyView)
        }
        set {
            set(associatedValue: newValue, key: "topView", object: self)
        }
    }
    var botView: UIView {
        get {
            return getAssociatedValue(key: "botView", object: self, initialValue: emptyView)
        }
        set {
            set(associatedValue: newValue, key: "botView", object: self)
        }
    }
    var leftView: UIView {
        get {
            return getAssociatedValue(key: "leftView", object: self, initialValue: emptyView)
        }
        set {
            set(associatedValue: newValue, key: "leftView", object: self)
        }
    }
    var rightView: UIView {
        get {
            return getAssociatedValue(key: "rightView", object: self, initialValue: emptyView)
        }
        set {
            set(associatedValue: newValue, key: "rightView", object: self)
        }
    }
}
extension AMKScroller {
    var actions: [String: () -> ()] {
        get {
            return getAssociatedValue(key: "actions", object: self, initialValue: [:])
        }
        set {
            set(associatedValue: newValue, key: "actions", object: self)
        }
    }
    /*var gesture: UIPanGestureRecognizer {
        get {
            return getAssociatedValue(key: "gesture", object: self, initialValue: UIPanGestureRecognizer.init(target: self, action: #selector(didPan)))
        }
        set {
            set(associatedValue: newValue, key: "gesture", object: self)
        }
    }*/
    var maxYSubviews: CGFloat {
        get {
            return getAssociatedValue(key: "maxYSubviews", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "maxYSubviews", object: self)
        }
    }
    var minYSubviews: CGFloat {
        get {
            return getAssociatedValue(key: "minYSubviews", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "minYSubviews", object: self)
        }
    }
    var maxXSubviews: CGFloat {
        get {
            return getAssociatedValue(key: "maxXSubviews", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "maxXSubviews", object: self)
        }
    }
    var minXSubviews: CGFloat {
        get {
            return getAssociatedValue(key: "minXSubviews", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "minXSubviews", object: self)
        }
    }
    var canScrollUp: Bool {
        get {
            return getAssociatedValue(key: "canScrollUp", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "canScrollUp", object: self)
        }
    }
    var canScrollDown: Bool {
        get {
            return getAssociatedValue(key: "canScrollDown", object: self, initialValue: true)
        }
        set {
            set(associatedValue: newValue, key: "canScrollDown", object: self)
        }
    }
    var scrolling: Bool {
        get {
            return getAssociatedValue(key: "scrolling", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "scrolling", object: self)
        }
    }
    var deltaDrag: CGPoint {
        get {
            return getAssociatedValue(key: "deltaDrag", object: self, initialValue: emptyPoint)
        }
        set {
            set(associatedValue: newValue, key: "deltaDrag", object: self)
        }
    }
    var scrollOffsets: CGRect {
        get {
            return getAssociatedValue(key: "scrollOffsets", object: self, initialValue: emptyRect)
        }
        set {
            set(associatedValue: newValue, key: "scrollOffsets", object: self)
        }
    }
    var bounceOffsets: CGRect {
        get {
            return getAssociatedValue(key: "bounceOffsets", object: self, initialValue: emptyRect)
        }
        set {
            set(associatedValue: newValue, key: "bounceOffsets", object: self)
        }
    }
    var sensibility: CGRect {
        get {
            return getAssociatedValue(key: "sensibility", object: self, initialValue: emptyRect)
        }
        set {
            set(associatedValue: newValue, key: "sensibility", object: self)
        }
    }
    var scrollAnchor: CGPoint {
        get {
            return getAssociatedValue(key: "scrollAnchor", object: self, initialValue: emptyPoint)
        }
        set {
            set(associatedValue: newValue, key: "scrollAnchor", object: self)
        }
    }
    var scrollSpeed: CGFloat {
        get {
            return getAssociatedValue(key: "scrollSpeed", object: self, initialValue: 1.0)
        }
        set {
            set(associatedValue: newValue, key: "scrollSpeed", object: self)
        }
    }
    var animator: UIDynamicAnimator {
        get {
            return getAssociatedValue(key: "animator", object: self, initialValue: UIDynamicAnimator.init(referenceView: self))
        }
        set {
            set(associatedValue: newValue, key: "animator", object: self)
        }
    }
}
extension AMKScroller {
    //MARK: Inspectable
    @IBInspectable var doAction: String {
        /*get {
            return getAssociatedValue(key: "doAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "doAction", object: self)
            actions["default"]!()
        }*/
        get {
            return ""
        }
        set {
            //actions["default"]!()
        }
    }
    @IBInspectable var extendOffsetsLTRB: String {
        get {
            return getAssociatedValue(key: "extendOffsetsLTRB", object: self, initialValue: "0|0|0|0")
        }
        set {
            set(associatedValue: newValue, key: "extendOffsetsLTRB", object: self)
            scrollOffsets = CGRect.loadFromEncrypted(Chain: extendOffsetsLTRB)
        }
    }
    @IBInspectable var bounceOffsetsLTRB: String {
        get {
            return getAssociatedValue(key: "bounceOffsetsLTRB", object: self, initialValue: "0|0|0|0")
        }
        set {
            set(associatedValue: newValue, key: "bounceOffsetsLTRB", object: self)
            bounceOffsets = CGRect.loadFromEncrypted(Chain: bounceOffsetsLTRB)
        }
    }
    @IBInspectable var deltaDragXY: String {
        get {
            return getAssociatedValue(key: "deltaDragXY", object: self, initialValue: "50|100")
        }
        set {
            set(associatedValue: newValue, key: "deltaDragXY", object: self)
            deltaDrag = CGPoint.loadFromEncrypted(Chain: deltaDragXY)
        }
    }
    @IBInspectable var dragSpeed: CGFloat {
        get {
            return getAssociatedValue(key: "dragSpeed", object: self, initialValue: 0.5)
        }
        set {
            set(associatedValue: newValue, key: "dragSpeed", object: self)
        }
    }
    @IBInspectable var sensibilityLTRB: String {
        get {
            return getAssociatedValue(key: "sensibilityLTRB", object: self, initialValue: "1|-1|-1|1")
        }
        set {
            set(associatedValue: newValue, key: "sensibilityLTRB", object: self)
            sensibility = CGRect.loadFromEncrypted(Chain: sensibilityLTRB)
        }
    }
}
