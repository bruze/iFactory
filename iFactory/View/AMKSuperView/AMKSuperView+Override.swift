//
//  AMKSuperView+Override.swift
//  iFactory
//
//  Created by Bruno Garelli on 1/31/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import Foundation
import UIKit
extension AMKSuperView {
    //MARK: AMKEncodable
    override func encode() {
        //let parsedData = ["": idleImage.imageAsset.debugDescription]
    }
    override func decode(_ data: NSDictionary) {
    }
}
extension AMKSuperView {
    //MARK: UIView
    override public var intrinsicContentSize: CGSize {
        let standardSize = frame.size
        let scale = UIScreen.main.bounds.width / 375.0
        let finalSize = CGSize.init(width: standardSize.width * scale, height: standardSize.height)
        return finalSize
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        //noti.addObserver(self, selector: #selector(handle), name: nil, object: nil)
        #if TARGET_INTERFACE_BUILDER
            if !storeLoaded && !storeID.isEmpty {
                label.storeID = storeID
                label.overrideStoredText = false
                addSubview(label)
                label.reloadAMKConfig()
            }
        #else
            if !storeLoaded && !storeID.isEmpty {
                label.storeID = storeID
                label.overrideStoredText = false
                if let path = bundle.path(forResource: storeID + ".plist", ofType: nil, inDirectory: "amk") {
                    let entityData = NSDictionary.init(contentsOfFile: path)
                    label.decode(entityData!)
                    addSubview(label)
                    label.reloadAMKConfig()
                    storeLoaded = true
                }
            }
        #endif
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        settleImageView()
    }
    /*override func didMoveToSuperview() {
        if superview != nil {
        }
    }
    override func prepareForInterfaceBuilder() {
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }*/
}
