//
//  AMKSuperView+Alignment.swift
//  iFactory
//
//  Created by Bruno Garelli on 1/31/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
private let alignmentOperators: [String: (_ p: CGRect, _ m: inout CGRect) -> ()] =
    [  "right": {parentFrame,myFrame in myFrame.x = parentFrame.width - myFrame.width; return },
        "left": {parentFrame,myFrame in myFrame.x = 0; return },
        "top": {parentFrame,myFrame in myFrame.y = 0; return },
        "bottom": {parentFrame,myFrame in myFrame.y = parentFrame.height - myFrame.height; return }
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
            alignmentOperators[component]!(superFrame!, &frame)
        }
    }
}
