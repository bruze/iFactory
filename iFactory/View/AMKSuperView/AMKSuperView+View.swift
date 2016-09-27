//
//  AMKSuperView+View.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
extension AMKSuperView {
    @IBInspectable var idleImageScale: CGFloat {
        get {
            return getProperty("idleImageScale", initial: 0)
        }
        set {
            setValue(newValue, forProperty: "idleImageScale")
            let imageSize = idleImage.size
            let scaled = frame.getScaledSize(newValue, overSize: imageSize)
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView, newSize: scaled)
        }
    }
    @IBInspectable var fonta: CGFont {
        get {
            return getProperty("fonta", initial: CGFontCreateWithFontName("")!)
        }
        set {
            setValue(newValue, forProperty: "fonta")
        }
    }
    override func drawRect(rect: CGRect) {
        //label.position = center
        //super.drawRect(rect)
        /*print(center.substract(label.center))
        label.frame.origin = center.substract(label.center)*/
        //super.drawRect(rect)
        let size = CGSize(width: 256, height: 256)
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        // *******************************************************************
        // Scale & translate the context to have 0,0
        // at the centre of the screen maths convention
        // Obviously change your origin to suit...
        // *******************************************************************
        CGContextTranslateCTM (context, size.width / 2, size.height / 2)
        CGContextScaleCTM (context, 1, -1)
        
        centreArcPerpendicularText("Hello round world", context: context, radius: 100, angle: 0, colour: UIColor.redColor(), font: UIFont.systemFontOfSize(16), clockwise: true)
        centreArcPerpendicularText("Anticlockwise", context: context, radius: 100, angle: CGFloat(-M_PI_2), colour: UIColor.redColor(), font: UIFont.systemFontOfSize(16), clockwise: false)
        centreText("Hello flat world", context: context, radius: 0, angle: 0 , colour: UIColor.yellowColor(), font: UIFont.systemFontOfSize(16), slantAngle: CGFloat(M_PI_4))
        addSubview(UIImageView.init(image: UIGraphicsGetImageFromCurrentImageContext()))
        UIGraphicsEndImageContext()
    }
}