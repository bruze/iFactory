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
internal let ScrollOperations: [Direction: (_ view: AMKScroller,_ subview: UIView,_ offset: CGFloat)->()] =
    [.left: {view,subview,off in
            var setValue = subview.frame.x - off
            let right = view.rightView
            if right == subview && setValue < 0 {
                setValue = 0
            }
            subview.frame.x = setValue; return},
     .right: {view,subview,off in
            var setValue = subview.frame.x + off
            let left = view.leftView
            if left == subview && setValue + subview.frame.w > view.w {
                setValue = view.w - subview.frame.w
            }
            subview.frame.x = setValue; return},
     .up: {view,subview,off in
            var setValue = subview.frame.y - off
            let bot = view.botView
            if bot == subview && setValue < 0 {
                setValue = 0
            }
            subview.frame.y = setValue; return},
     .down: {view,subview,off in
            var setValue = subview.frame.y + off
            let top = view.topView
            if top == subview && setValue + subview.frame.h > view.h {
                setValue = view.h - subview.frame.h
            }
            subview.frame.y = setValue; return}]
internal let ScrollModeOperators: [ScrollMode: (_ view: AMKScroller, _ moves: [Direction])->ScrollAllowed] = [
    .normalize: {view,moves in
        var result = defaultScrollAllowed
        let first = view.topView//view.subviews.first!
        let last = view.botView//view.subviews.last!
        //if !(last.frame.y + decreaser < maxYSubviews) {
        if first.frame.y >= 0 {
            result[.down] = false
            //} else if !(first.frame.y + decreaser > -maxYSubviews) {
        } else if last.frame.y + last.size.height <= view.size.height {
            result[.up] = false
        }
        let left = view.leftView
        let right = view.rightView
        if right.frame.x + right.size.width >= view.size.width {
            result[.right] = false
        } else if left.frame.x <= 0 {
            result[.left] = false
            /*if let superView = view.superview {
                let coord = superView.convert(left.frame, to: superView)
                print(coord)
                print(view.rightView)
                if coord.x <= -view.w {
                    result[.left] = false
                }
            }*/
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
    var gesture: UIPanGestureRecognizer {
        get {
            return getAssociatedValue(key: "gesture", object: self, initialValue: UIPanGestureRecognizer.init(target: self, action: #selector(didPan)))
        }
        set {
            set(associatedValue: newValue, key: "gesture", object: self)
        }
    }
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
            return getAssociatedValue(key: "extendOffsetsLTRB", object: self, initialValue: "50|100")
        }
        set {
            set(associatedValue: newValue, key: "extendOffsetsLTRB", object: self)
            scrollOffsets = CGRect.loadFromEncrypted(Chain: extendOffsetsLTRB)
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
}
