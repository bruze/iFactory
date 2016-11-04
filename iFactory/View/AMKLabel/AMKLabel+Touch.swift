//
//  AMKLabel+Touch.swift
//  iFactory
//
//  Created by Bruno Garelli on 11/3/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

extension AMKLabel {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print("Label Touch")
        if mutateOnTouch && !mutateStoreID.isEmpty {
            storeID = mutateStoreID
            reloadAMKConfig()
        }
    }
    /*override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }*/
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        initialConfig()
        delegatePerformTouch()
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        initialConfig()
    }
    /*override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
        print("What???")
    }*/
}
