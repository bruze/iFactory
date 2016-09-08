//
//  AMKButton+Label.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/5/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension AMKButton {
    internal func addLabelWith(Text labelText: String, AndOffset offset: CGPoint) {
        let label = UILabel.init(frame: CGRect.init(x: offset.x, y: offset.y, w: w - (w/6), h: h - (h / 4)))
        label.tag = AMKTypeTag.LabelDefault.rawValue
        label.text = labelText
        addSubview(label)
        label.centerYInSuperView()
        updateViews()
    }
}
