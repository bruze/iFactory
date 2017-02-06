//
//  CGPoint+Encrypt.swift
//  iFactory
//
//  Created by Bruno Garelli on 2/5/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import UIKit
//import Foundation
extension CGPoint {
    static func loadFromEncrypted(Chain data: String) -> CGPoint {
        var result = CGPoint.init(x: 0.0, y: 0.0)
        let components = data.components(separatedBy: "|")
        result = CGPoint.init(x: CGFloat(components[0].toFloat()!), y: CGFloat(components[1].toFloat()!))
        return result
    }
}
