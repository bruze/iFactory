//
//  AMKEncoder+Extension.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/8/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import Foundation

extension String {
    mutating func readLine() -> String {
        //let index = self.indexOf("\n")
        let range = self.rangeOfString("\n")
        let line = self.substringToIndex((range?.endIndex)!)
        //let value = self.substring(0, length: index!)
        self.removeRange(self.startIndex...(range?.startIndex)!)
        //print(self)
        return line
    }
    func readStoredValue(key: String) -> String {
        let index = self.indexOf(key + ">")
        let keyLength = key.characters.count
        let start = index! + keyLength + 1
        let value = self.substring(start, length: self.indexOf("\n")! - start)
        return value
    }
    mutating func getNextValueForModel(key: String, cutAt: String) -> Int {
        let range = rangeOfString(key)
        let indexStop = rangeOfString(cutAt)
        let indexRange = (range?.endIndex)!...(indexStop?.startIndex)!.predecessor()
        let indexRemove = (range?.startIndex)!...(indexStop?.startIndex)!
        let value = substringWithRange(indexRange)
        removeRange(indexRemove)
        return Global.stringToInt(value)!
    }
}