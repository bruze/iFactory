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
        return CGPoint.init(x: x - point.x, y: y - point.y)
    }
    
    func add(_ point: CGPoint) -> CGPoint {
        return CGPoint.init(x: x + point.x, y: y + point.y)
    }
}
