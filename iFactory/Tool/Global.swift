//
//  Global.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/9/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation

public struct Global {
    static public func stringToInt(value: String) -> Int? {
        if let num = NSNumberFormatter().numberFromString(value) {
            return num.integerValue
        } else {
            return nil
        }
    }
}