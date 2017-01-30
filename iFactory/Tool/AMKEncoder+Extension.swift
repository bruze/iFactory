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
        let range = self.range(of: "\n")
        let line = self.substring(to: (range?.upperBound)!)
        //let value = self.substring(0, length: index!)
        self.removeSubrange(self.startIndex...(range?.lowerBound)!)
        //print(self)
        return line
    }
    func readStoredValue(_ key: String) -> String {
        let index = self.indexOf(key + ">")
        let keyLength = key.characters.count
        let start = index! + keyLength + 1
        let value = self.substring(start, length: self.indexOf("\n")! - start)
        return value
    }
    mutating func getNextValueForModel(_ key: String, cutAt: String) -> Int {
        let range = self.range(of: key)
        let indexStop = self.range(of: cutAt)
        let indexRange = (range?.upperBound)!..<(indexStop?.lowerBound)!
        let indexRemove = (range?.lowerBound)!...(indexStop?.lowerBound)!
        let value = self.substring(with: indexRange)
        removeSubrange(indexRemove)
        return Global.stringToInt(value)!
    }
}
