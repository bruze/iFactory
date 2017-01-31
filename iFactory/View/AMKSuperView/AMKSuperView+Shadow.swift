//
//  AMKSuperView+Shadow.swift
//  e2e
//
//  Created by Bruno Garelli on 1/25/17.
//  Copyright © 2017 Altimetrik. All rights reserved.
//
import EZSwiftExtensions
import AssociatedValues
extension AMKSuperView {
    func setShadow() {
        /*layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4*/
        setNeedsDisplay()
    }
    func getSizeShdwInset() -> CGSize {
        let components = shadowInsets.components(separatedBy: "|")
        let result = CGSize.init(width: components[0].toInt()!, height: components[1].toInt()!)
        return result
    }
}
