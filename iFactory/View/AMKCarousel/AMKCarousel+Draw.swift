//
//  AMKCarousel+Draw.swift
//  e2e
//
//  Created by Bruno Garelli on 10/10/16.
//  Copyright © 2016 Altimetrik. All rights reserved.
//

extension AMKCarousel {
    /*override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        ////////////////////
        if !showIndicator { return }
        ////////////////////
        let screenSize = UIScreen.mainScreen().bounds
        var tW = 10
        var tH = 10
        var increment = CGFloat(15)
        if screenSize.height >= 1024 {
            tW = 20
            tH = 20
            increment = 25
        }
        let tSize = CGSize.init(width: tW, height: tH)
        //let pointsModule = viewPointsIndicator % 2

        let matters = viewPointsIndicator.isEven ? viewPointsIndicator : viewPointsIndicator - 1
        let module = ((matters / 2) + 1)
        let trail = (module * 10) - (5 * (module - 1))
        //let separation = CGFloat(15 * pointsModule)
        var iOrigin = CGPoint.init(x: w / 2 - CGFloat(trail), y: /*h * 3 / 4*/h - increment)
        if viewPointsIndicator > 0 {
            for index in 1...viewPointsIndicator {
                if index == /*currentIndicator*/scrollView.currentIndex + 1 {
                    if indicatorColor != UIColor.clearColor() {
                        indicatorColor.setFill()
                    } else {
                        UIColor.orangeColor().setFill()
                    }
                } else {
                    UIColor.grayColor().setFill()
                }
                let path = UIBezierPath.init(ovalInRect: CGRect.init(origin: iOrigin, size: tSize))
                path.fill()
                iOrigin.x += increment
            }
        }
    }*/
}

