//
//  CGRect+Encrypt.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/5/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import UIKit
extension CGRect {
    static func loadFromEncrypted(Chain data:String) -> CGRect {
        var result = CGRect.init(x: 0.0, y: 0.0, w: 0.0, h: 0.0)
        let components = data.components(separatedBy: "|")
        if components.count == 4 {
            result.x = CGFloat(components[0].toFloat()!)
            result.y = CGFloat(components[1].toFloat()!)
            result.w = CGFloat(components[2].toFloat()!)
            result.h = CGFloat(components[3].toFloat()!)
        }
        return result
    }
}
