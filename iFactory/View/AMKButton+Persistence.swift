//
//  AMKButton+Persistence.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/7/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation
import SwiftFilePath

extension AMKButton {
    internal func encode() {
        //let textFile = Path.documentsDir[storeID + ".txt"]
        //textFile.writeString(touchAction + "\n")
        //NSUserDefaults.standardUserDefaults().setObject("stored", forKey: "stored")
        /*for action in actions {
            textFile.writeString(action+"\n")
        }*/
     }
    internal func decode() {
        //let textFile = Path.documentsDir[storeID + ".txt"]
        /*if let text = textFile.readString() {
            let components = text.componentsSeparatedByString("\n")
            for component in components {
                actions.append(component)
            }
        }*/
     }
}