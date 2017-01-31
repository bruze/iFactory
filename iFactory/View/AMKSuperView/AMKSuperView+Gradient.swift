//
//  AMKSuperView+Gradient.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/27/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//
import UIKit
import AssociatedValues
extension AMKSuperView {
    internal func tryShowGradient() {
        capaGradiente = CAGradientLayer()
        //capaGradiente.removeFromSuperlayer()
        capaGradiente.colors = [gradienteInicial.cgColor, gradienteFinal.cgColor]
        capaGradiente.locations = [0.0, 1.0]
        capaGradiente.startPoint = CGPoint(x: 0.0, y: 1.0)
        capaGradiente.endPoint = CGPoint(x: 1.0, y: 1.0)
        capaGradiente.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
        //backgroundColor = UIColor.clearColor()
        layer.insertSublayer(capaGradiente, at: 0)
        layoutIfNeeded()
    }
}
