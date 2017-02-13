//
//  CGPoint+Aritmetic.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension CGPoint {
    func substract(_ point: CGPoint) -> CGPoint {
        var xRes = CGFloat(0)
        var yRes = CGFloat(0)
        if x < 0 && point.x < 0 {
            xRes = x + point.x
        } else {
            xRes = x - point.x
        }
        if y < 0 && point.y < 0 {
            yRes = y + point.y
        } else {
            yRes = y - point.y
        }
        return CGPoint.init(x: xRes, y: yRes)
    }
    
    func add(_ point: CGPoint) -> CGPoint {
        return CGPoint.init(x: x + point.x, y: y + point.y)
    }
}
