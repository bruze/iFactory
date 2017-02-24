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
        //clipsToBounds = false
        backgroundColor = UIColor.red
        //actions["default"] = defaultAction
        //addGestureRecognizer(gesture)
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
        //var continueIterating = true
        for sv in subviews {
            /*if !continueIterating {
                self.scrolling = false
                break
            }*/
            for move in moves {
                ScrollOperations[move]!(self, sv, move.isHMove() ? self.deltaDrag.x : self.deltaDrag.y, scrollSpeed)
            }
            /*animate(duration: TimeInterval(dragSpeed), animations: {
                for move in moves {
                    /*continueIterating =*/ ScrollOperations[move]!(self, sv, move.isHMove() ? self.deltaDrag.x : self.deltaDrag.y)
                    /*if !continueIterating {
                        //self.scrolling.toggle()
                        break
                    }*/
                }
            }, completion: { (completed) in
                if sv == self.subviews.last {
                    self.scrolling.toggle()
                }
            })*/
        }
        scrolling.toggle()
    }
    /*func check(View view: UIView, For move: Direction) -> Bool {
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
    }*/
    func movesFor(Translation translation: CGPoint) -> [Direction] {
        var setMoves: [Direction] = []
        if translation.y > /*60*/sensibility.h {
            setMoves.append(.down)
        } else if translation.y < /*-60*/sensibility.y {
            setMoves.append(.up)
        }
        if translation.x > /*60*/sensibility.x {
            setMoves.append(.right)
        } else if translation.x < /*-60*/sensibility.w {
            setMoves.append(.left)
        }
        return setMoves
    }
    /*func didPan(recognizer: UIPanGestureRecognizer) {
        if !scrolling {
            scrolling.toggle()
            //////////////////////////////////////////////////
            let translation = recognizer.translation(in: self)
            let speed = recognizer.velocity(in: self)
            //print(speed)
            /*var setMoves: [Direction] = []
            if translation.y > 60 {
                setMoves.append(.down)
            } else if translation.y < -60 {
                setMoves.append(.up)
            }
            if translation.x > 60 {
                setMoves.append(.right)
            } else if translation.x < -60 {
                setMoves.append(.left)
            }*/
            scroll(moves: movesFor(Translation: translation))
        }
    }*/
}
