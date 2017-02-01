//
//  AMKSuperView+Alignment.swift
//  iFactory
//
//  Created by Bruno Garelli on 1/31/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
private let alignmentOperators: [String: (_ p: CGRect, _ m: inout CGRect, _ o: CGPoint) -> ()] =
    [  "right": {parentFrame,myFrame,offset in myFrame.x = parentFrame.width - myFrame.width + offset.x; return },
        "left": {parentFrame,myFrame,offset in myFrame.x = 0 + offset.x; return },
        "top": {parentFrame,myFrame,offset in myFrame.y = 0 + offset.y; return },
        "bottom": {parentFrame,myFrame,offset in myFrame.y = parentFrame.height - myFrame.height + offset.y; return }
     ]
extension AMKSuperView {
    func realign() {
        //removeConstraints(constraints)
        //superview?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        /*let aConstraint = NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 250.0)
        superview!.addConstraint(aConstraint)*/
        guard !alignment.isEmpty else {
            return
        }
        let superFrame = superview?.frame
        let components = alignment.components(separatedBy: "|")
        for component in components {
            alignmentOperators[component]!(superFrame!, &frame, alignmentOffsets)
        }
    }
    func getAlignmentOffsets() -> CGPoint {
        let components = alignOffsets.components(separatedBy: "|")
        let result = CGPoint.init(x: components[0].toInt()!, y: components[1].toInt()!)
        return result
    }
}
