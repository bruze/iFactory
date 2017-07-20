//
//  Global.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/9/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import UIKit

let bundle = Bundle.main
let fileMan = FileManager.default
let noti = NotificationCenter.default
//////////////////////////////////
let emptyEncryptPoint = "0|0"
let emptyEncryptRect = "0|0|0|0"
let emptyPoint = CGPoint.init()
let emptyRect = CGRect.init()
let emptyLayer = CALayer.init()
let emptyImage = UIImage.init()
let emptyView  = UIView.init()
let emptyImageView = UIImageView.init()
//////////////////////////////////
enum Direction: Int {
    case left = 0
    case right = 1
    case up = 2
    case down = 4
    func isHMove() -> Bool {
        return self == .left || self == .right
    }
    func isVMove() -> Bool {
        return !isHMove()
    }
}
enum ScrollMode {
    case normalize
    case customOffset
    case autoOffset
}
//////////////////////////////////
func any2<T>(obj: Any, cast2: T.Type) -> T {
    return (obj as? T)!
}
//////////////////////////////////
public struct Global {
    enum RLMove {
        case right
        case left
    }
    static public func stringToInt(_ value: String) -> Int? {
        if let num = NumberFormatter().number(from: value) {
            return num.intValue
        } else {
            return nil
        }
    }
    static func scaleRelativeToStandardSize(myStandardSize: CGSize) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let scale = screenSize.width / 375.0
        let finalSize = CGSize.init(width: myStandardSize.width * scale, height: myStandardSize.height * scale)
        return finalSize
    }
}
