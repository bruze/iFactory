//
//  AMKScroller+Override.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/1/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import UIKit
extension AMKScroller {
    //MARK: UIView
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        let subFrame = subview.frame
        let comboY = subFrame.height + subFrame.y
        if comboY > maxYSubviews {
            maxYSubviews = comboY
        }
    }
}

