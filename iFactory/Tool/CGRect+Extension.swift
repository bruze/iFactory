//
//  CGRect+Extension.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/8/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import Foundation
import UIKit

extension CGRect {
    func toString() -> String {
        return ",".join(["=".join(["x", String(describing: x)]),
                         "=".join(["y", String(describing: y)]),
                         "=".join(["w", String(describing: w)]),
                         "=".join(["h", String(describing: h) + ","]) ])
    }
    
    static public func loadFromString(_ model: String) -> CGRect {
        var lModel = model
        let xValue = lModel.getNextValueForModel("x=", cutAt: ",")
        let yValue = lModel.getNextValueForModel("y=", cutAt: ",")
        let wValue = lModel.getNextValueForModel("w=", cutAt: ",")
        let hValue = lModel.getNextValueForModel("h=", cutAt: ",")
        return CGRect.init(x: xValue, y: yValue, width: wValue, height: hValue)
    }
    
    func getScaledSize(_ factor: CGFloat, overSize: CGSize) -> CGSize {
        return CGSize.init(width: w * (factor / overSize.width), height: h * (factor / overSize.height))
    }
}
