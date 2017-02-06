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
            botView = subview
            setEmptyViewsWith(botView)
        } else if comboY < minYSubviews {
            minYSubviews = comboY
            topView = subview
            setEmptyViewsWith(topView)
        }
        let comboX = subFrame.width + subFrame.x
        if comboX > maxXSubviews {
            maxXSubviews = comboX
            rightView = subview
            setEmptyViewsWith(rightView)
        } else if comboX < minXSubviews {
            minXSubviews = comboX
            leftView = subview
            setEmptyViewsWith(leftView)
        }
    }
    func setEmptyViewsWith(_ view: UIView) {
        if leftView == emptyView {
            leftView = view
        }
        if rightView == emptyView {
            rightView = view
        }
        if topView == emptyView {
            topView = view
        }
        if botView == emptyView {
            botView = view
        }
    }
}

