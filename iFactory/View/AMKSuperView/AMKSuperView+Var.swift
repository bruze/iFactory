//
//  AMKSuperView+Var.swift
//  iFactory
//
//  Created by Bruno Garelli on 1/31/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import AssociatedValues
extension AMKSuperView {
    //MARK: Image
    @IBInspectable var adoptImgSize: Bool {
        get {
            return getAssociatedValue(key: "adoptImgSize", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "adoptImgSize", object: self)
        }
    }
    @IBInspectable var idleImage: UIImage {
        get {
            return getAssociatedValue(key: "idleImage", object: self, initialValue: emptyImage)
        }
        set {
            set(associatedValue: newValue, key: "idleImage", object: self)
            var size = newValue.size
            var setX = centerX - size.width / 2
            var setY = centerY - size.height / 2
            !idlePositionAngle.isZero && !idlePositionRadius.isZero ? {
                setX += cos(idlePositionAngle.toRadians()) * idlePositionRadius
                setY -= sin(idlePositionAngle.toRadians()) * idlePositionRadius
                }() : {}()
            if idleImageScale != 0 {
                size = frame.getScaledSize(idleImageScale, overSize: newValue.size)
            }
            addIdleImageView(CGPoint.init(x: setX, y: setY), size: size, image: newValue)
        }
    }
    @IBInspectable var idlePositionAngle: CGFloat {
        get {
            return getAssociatedValue(key: "idlePositionAngle", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "idlePositionAngle", object: self)
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView)
        }
    }
    @IBInspectable var idlePositionRadius: CGFloat {
        get {
            return getAssociatedValue(key: "idlePositionRadius", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "idlePositionRadius", object: self)
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView)
        }
    }
    var idleImageView: UIImageView {
        get {
            return getAssociatedValue(key: "idleImageView", object: self, initialValue: emptyImageView)
        }
        set {
            set(associatedValue: newValue, key: "idleImageView", object: self)
        }
    }
}
extension AMKSuperView {
    //MARK: General
    @IBInspectable var storeButtonID: String {
        get {
            return getAssociatedValue(key: "storeButtonID", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "storeButtonID", object: self)
            encode()
        }
    }
    //MARK: Action on Touch
    @IBInspectable dynamic var touchAction: String {
        get {
            return getAssociatedValue(key: "touchAction", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "touchAction", object: self)
        }
    }
    @IBOutlet var delegate: AnyObject? {
        get {
            return getAssociatedValue(key: "delegate", object: self, initialValue: nil)
        }
        set {
            set(associatedValue: newValue, key: "delegate", object: self)
        }
    }
}
extension AMKSuperView {
    //MARK: Background
    @IBInspectable var backColor: UIColor {
        get {
            return getAssociatedValue(key: "defBackColor", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "defBackColor", object: self)
            backgroundColor = newValue
        }
    }
    @IBInspectable var touchBackColor: UIColor {
        get {
            return getAssociatedValue(key: "touchBackColor", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "touchBackColor", object: self)
        }
    }
}
extension AMKSuperView {
    //MARK: View
    @IBInspectable var idleImageScale: CGFloat {
        get {
            return getAssociatedValue(key: "idleImageScale", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "idleImageScale", object: self)
            let imageSize = idleImage.size
            let scaled = frame.getScaledSize(newValue, overSize: imageSize)
            updateImageViewLocation(idlePositionAngle, radius: idlePositionRadius, imageView: &idleImageView, newSize: scaled)
        }
    }
    @IBInspectable var fonta: CGFont {
        get {
            let initialStr: CFString = "" as CFString
            return getAssociatedValue(key: "fonta", object: self, initialValue: CGFont.init(initialStr)!)
        }
        set {
            set(associatedValue: newValue, key: "fonta", object: self)
        }
    }
}
extension AMKSuperView {
    //MARK: Label
    dynamic var label: AMKLabel {
        get {
            return getAssociatedValue(key: "label", object: self, initialValue: AMKLabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 80)))
        }
        set {
            set(associatedValue: newValue, key: "label", object: self)
        }
    }
}
extension AMKSuperView {
    //MARK: Touch
    @IBInspectable var blinkIfNoTouchImage: Bool {
        get {
            return getAssociatedValue(key: "blinkOnTouch", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "blinkOnTouch", object: self)
        }
    }
    @IBInspectable var blinkLabelToo: Bool {
        get {
            return getAssociatedValue(key: "blinkLabelToo", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "blinkLabelToo", object: self)
        }
    }
    @IBInspectable var touchImage: UIImage {
        get {
            return getAssociatedValue(key: "touchImage", object: self, initialValue: emptyImage)
        }
        set {
            set(associatedValue: newValue, key: "touchImage", object: self)
            let size = newValue.size
            //var setX = centerX - size.width / 2
            //var setY = centerY - size.height / 2
            var setX = /*centerX*/frame.size.width / 2 - size.width / 2
            var setY = /*centerY*/frame.size.height / 2 - size.height / 2
            !touchPositionAngle.isZero && !touchPositionRadius.isZero ? {
                setX += cos(touchPositionAngle.toRadians()) * touchPositionRadius
                setY -= sin(touchPositionAngle.toRadians()) * touchPositionRadius
                }() : {}()
            addTouchImageView(CGPoint.init(x: setX, y: setY), size: size, image: touchImage)
        }
    }
    @IBInspectable var touchPositionAngle: CGFloat {
        get {
            return getAssociatedValue(key: "touchPositionAngle", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "touchPositionAngle", object: self)
            updateImageViewLocation(touchPositionAngle, radius: touchPositionRadius, imageView: &touchImageView)
        }
    }
    @IBInspectable var touchPositionRadius: CGFloat {
        get {
            return getAssociatedValue(key: "touchPositionRadius", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "touchPositionRadius", object: self)
            updateImageViewLocation(touchPositionAngle, radius: touchPositionRadius, imageView: &touchImageView)
        }
    }
    var touchImageView: UIImageView {
        get {
            return getAssociatedValue(key: "touchImageView", object: self, initialValue: emptyImageView)
        }
        set {
            set(associatedValue: newValue, key: "touchImageView", object: self)
        }
    }
}
extension AMKSuperView {
    //MARK: Border
    var hasBorder: Bool {
        get {
            return getAssociatedValue(key: "hasBorder", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "hasBorder", object: self)
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            return getAssociatedValue(key: "borderColor", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "borderColor", object: self)
            borderWidth.isZero && !hasBorder ? {}() : { self.addBorderTo(layer, width: self.borderWidth, color: newValue); self.hasBorder.toggle() }()
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return getAssociatedValue(key: "borderWidth", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "borderWidth", object: self)
            borderColor.isEmpty() && !hasBorder ? {}() : { addBorderTo(layer, width: newValue, color: borderColor); self.hasBorder.toggle() }()
        }
    }
    @IBInspectable var roundCorners: CGFloat {
        get {
            return getAssociatedValue(key: "roundCorners", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "roundCorners", object: self)
            layer.cornerRadius = newValue
        }
    }
}
extension AMKSuperView {
    //MARK: Gradient
    var capaGradiente: CAGradientLayer {
        get {
            return getAssociatedValue(key: "capaGradiente", object: self, initialValue: CAGradientLayer.init())
        }
        set {
            set(associatedValue: newValue, key: "capaGradiente", object: self)
        }
    }
    @IBInspectable var gradienteInicial: UIColor {
        get {
            return getAssociatedValue(key: "gradienteInicial", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "gradienteInicial", object: self)
            if !gradienteFinal.isEmpty() {
                tryShowGradient()
            }
        }
    }
    
    @IBInspectable var gradienteFinal: UIColor {
        get {
            return getAssociatedValue(key: "gradienteFinal", object: self, initialValue: UIColor.clear)
        }
        set {
            set(associatedValue: newValue, key: "gradienteFinal", object: self)
            if !gradienteInicial.isEmpty() {
                tryShowGradient()
            }
        }
    }
}
extension AMKSuperView {
    //MARK: Shadow
    @IBInspectable var shadowInsets: String {
        get {
            return getAssociatedValue(key: "shadowInsets", object: self, initialValue: "0|0")
        }
        set {
            set(associatedValue: newValue, key: "shadowInsets", object: self)
            layer.shadowOffset = getSizeShdwInset()
            idleImageView.layer.shadowOffset = getSizeShdwInset()
        }
    }
    @IBInspectable var shdwColor: UIColor {
        get {
            return getAssociatedValue(key: "shdwColor", object: self, initialValue: UIColor.darkGray)
        }
        set {
            set(associatedValue: newValue, key: "shdwColor", object: self)
            layer.shadowColor = shdwColor.cgColor
            idleImageView.layer.shadowColor = shdwColor.cgColor
        }
    }
    @IBInspectable var shdwRadius: CGFloat {
        get {
            return getAssociatedValue(key: "shdwRadius", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "shdwRadius", object: self)
            layer.shadowRadius = shdwRadius
            idleImageView.layer.shadowRadius = shdwRadius
        }
    }
    @IBInspectable var shdwOpacity: Float {
        get {
            return getAssociatedValue(key: "shdwOpacity", object: self, initialValue: 0)
        }
        set {
            set(associatedValue: newValue, key: "shdwOpacity", object: self)
            layer.shadowOpacity = shdwOpacity
            idleImageView.layer.shadowOpacity = shdwOpacity
        }
    }
    @IBInspectable var dropShdw: Bool {
        get {
            return getAssociatedValue(key: "dropShdw", object: self, initialValue: false)
        }
        set {
            set(associatedValue: newValue, key: "dropShdw", object: self)
            setShadow()
        }
    }
}
extension AMKSuperView {
    //MARK: Alignment
    @IBInspectable var alignment: String {
        get {
            return getAssociatedValue(key: "alignment", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "alignment", object: self)
            realign()
        }
    }
    internal var alignmentOffsets: CGPoint {
        get {
            return getAssociatedValue(key: "alignmentOffsets", object: self, initialValue: CGPoint.zero)
        }
        set {
            set(associatedValue: newValue, key: "alignmentOffsets", object: self)
        }
    }
    @IBInspectable var alignOffsets: String {
        get {
            return getAssociatedValue(key: "alignOffsets", object: self, initialValue: "")
        }
        set {
            set(associatedValue: newValue, key: "alignOffsets", object: self)
            alignmentOffsets = getAlignmentOffsets()
            print(alignmentOffsets)
            realign()
        }
    }
}
