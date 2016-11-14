//
//  AMKSuperView+Inspectable.swift
//  iFactory
//
//  Created by Bruno Garelli on 11/7/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBInspectable var storeButtonID: String {
        get {
            return getProperty("storeButtonID", initial: "")
        }
        set {
            setValue(newValue, forProperty: "storeButtonID")
            encode()
        }
    }
    override func encode() {
        let parsedData = ["": idleImage.imageAsset.debugDescription]
        print(parsedData)
    }
    override func decode(data: NSDictionary) {
        print()
    }
}
