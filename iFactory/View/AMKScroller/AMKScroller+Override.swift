//
//  AMKScroller+Override.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/1/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import UIKit
extension AMKScroller: UIDynamicAnimatorDelegate {
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
        } else if comboY < minYSubviews {
            minYSubviews = comboY
            topView = subview
        }
        let comboX = subFrame.width + subFrame.x
        if comboX > maxXSubviews {
            maxXSubviews = comboX
            rightView = subview
        } else if comboX < minXSubviews {
            minXSubviews = comboX
            leftView = subview
        }
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setEmptyViews()
        /*let animator = UIDynamicAnimator(referenceView: self)
        let dynamicItem = UIDynamicItemBehavior(items: [topView])
        dynamicItem.allowsRotation = false
        dynamicItem.elasticity = 0.3
        
        let gravity = UIGravityBehavior(items: [topView])
        gravity.gravityDirection = CGVector.init(dx: 0, dy: 1)
        let container = UICollisionBehavior(items: [topView])
        //configurecontainer
        //let width = UIScreen.main.bounds.size.width
        container.addBoundary(withIdentifier: "upper" as NSCopying, from: CGPoint.init(x: topView.frame.x, y: topView.frame.y), to: CGPoint.init(x: topView.frame.x, y: topView.frame.y - topView.frame.h))
        //let height = UIScreen.main.bounds.size.height*0.66
        container.addBoundary(withIdentifier: "lower" as NSCopying, from: CGPoint.init(x: topView.frame.x, y: topView.frame.y), to: CGPoint.init(x: topView.frame.x, y: topView.frame.y + topView.frame.h))
        //endconfiguring
        animator.addBehavior(gravity)
        animator.addBehavior(dynamicItem)
        animator.addBehavior(container)
        animator.delegate = self*/
        let collider = UICollisionBehavior.init()
        collider.addItem(topView)
        collider.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collider)
        animator.delegate = self
    }
    func setEmptyViews() {
        if leftView == emptyView {
            if rightView == emptyView {
                if botView == emptyView {
                    botView = topView
                    rightView = topView
                    leftView = topView
                } else {
                    rightView = botView
                    leftView = botView
                }
            } else {
                leftView = rightView
            }
        }
        if rightView == emptyView {
            if leftView == emptyView {
                if botView == emptyView {
                    botView = topView
                    leftView = topView
                    rightView = topView
                } else {
                    leftView = botView
                    rightView = botView
                }
            } else {
                rightView = leftView
            }
        }
        if topView == emptyView {
            if botView == emptyView {
                if leftView == emptyView {
                    leftView = rightView
                    botView = rightView
                    topView = rightView
                } else {
                    botView = leftView
                    topView = leftView
                }
            } else {
                topView = botView
            }
        }
        if botView == emptyView {
            if topView == emptyView {
                if leftView == emptyView {
                    leftView = rightView
                    topView = rightView
                    botView = rightView
                } else {
                    topView = leftView
                    botView = leftView
                }
            } else {
                botView = topView
            }
        }
    }
}

