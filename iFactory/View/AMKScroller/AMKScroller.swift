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
        clipsToBounds = false
        backgroundColor = UIColor.red
        //actions["default"] = defaultAction
        addGestureRecognizer(gesture)
    }
    func scroll(moves: [Direction]) {
        //CHECKS
        var moves = moves
        let checkScroll = ScrollModeOperators[.normalize]!(self, moves)
        for move in moves {
            if !checkScroll[move]! {
                moves.removeObject(move)
            }
        }
        guard moves.count > 0 else {
            scrolling.toggle()
            return
        }
        //PERFORM MOVES
        for sv in subviews {
            animate(duration: TimeInterval(dragSpeed), animations: {
                for move in moves {
                    ScrollOperations[move]!(self, sv, move.isHMove() ? self.deltaDrag.x : self.deltaDrag.y)
                }
            }, completion: { (completed) in
                if sv == self.subviews.last {
                    self.scrolling.toggle()
                }
            })
        }
    }
    func check(View view: UIView, For move: Direction) -> Bool {
        switch move {
        case .down:
            return view == topView
        case .left:
            return view == leftView
        case .right:
            return view == rightView
        case .up:
            return view == botView
        }
    }
    func didPan(recognizer: UIPanGestureRecognizer) {
        if !scrolling {
            scrolling.toggle()
            //////////////////////////////////////////////////
            let translation = recognizer.translation(in: self)
            var setMoves: [Direction] = []
            if translation.y > 0 {
                setMoves.append(.up)
            } else if translation.y < 0 {
                setMoves.append(.down)
            }
            if translation.x > 0 {
                setMoves.append(.left)
            } else if translation.x < 0 {
                setMoves.append(.right)
            }
            scroll(moves: setMoves)
        }
    }
}
