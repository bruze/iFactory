//
//  AMKSuperView+Border.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import AssociatedValues
import UIKit
extension AMKSuperView {
    public func addBorderTo(_ layer: CALayer, width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        //layer.masksToBounds = true
    }
}
