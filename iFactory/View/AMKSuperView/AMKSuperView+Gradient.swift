//
//  AMKSuperView+Gradient.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import UIKit
extension AMKSuperView {
    var capaGradiente: CAGradientLayer {
        get {
            return getProperty("capaGradiente", initial: CAGradientLayer.init())
        }
        set {
            setValue(newValue, forProperty: "capaGradiente")
        }
    }
    @IBInspectable var gradienteInicial: UIColor {
        get {
            return getProperty("gradienteInicial", initial: UIColor.clearColor())
        }
        set {
            setValue(newValue, forProperty: "gradienteInicial")
            if !gradienteFinal.isEmpty() {
                tryShowGradient()
            }
        }
    }
    
    @IBInspectable var gradienteFinal: UIColor {
        get {
            return getProperty("gradienteFinal", initial: UIColor.clearColor())
        }
        set {
            setValue(newValue, forProperty: "gradienteFinal")
            if !gradienteInicial.isEmpty() {
                tryShowGradient()
            }
        }
    }
    
    internal func tryShowGradient() {
        capaGradiente = CAGradientLayer()
        //capaGradiente.removeFromSuperlayer()
        capaGradiente.colors = [gradienteInicial.CGColor, gradienteFinal.CGColor]
        capaGradiente.locations = [0.0, 1.0]
        capaGradiente.startPoint = CGPoint(x: 0.0, y: 1.0)
        capaGradiente.endPoint = CGPoint(x: 1.0, y: 1.0)
        capaGradiente.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        //backgroundColor = UIColor.clearColor()
        layer.insertSublayer(capaGradiente, atIndex: 0)
        layoutIfNeeded()
    }
}
