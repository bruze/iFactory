//
//  AMKCarousel+Scroll.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/8/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import LTInfiniteScrollView

extension AMKCarousel: LTInfiniteScrollViewDataSource, LTInfiniteScrollViewDelegate {
    var scrollView: LTInfiniteScrollView {
        get {
            let scroll = getProperty("scrollView", initial: LTInfiniteScrollView.init(frame: bounds))
            return scroll
        }
        set {
            setValue(newValue, forProperty: "scrollView")
        }
    }
    
    func viewAtIndex(index: Int, reusingView view: UIView?) -> UIView {
        //let button = AMKButton.init(frame: CGRect.zero)
        //button.defaultLabel = "Hello"
        /*button.pressBackColor = UIColor.cyanColor()
         button.defaultImage = UIImage.init(named: "iconMyRedemp")
         button.pressImage = UIImage.init(named: "iconRedeemPoints")*/
        //button.storeID = "DashButton" + String(index)
        //button.decode()
        /*if storeID == "specialCarrousel" {
            let carousel = AMKCarousel.init(frame: CGRect.init(x: 400, y: 200, w: 200, h: 200))
            carousel.setupScroll()
            carousel.scrollView.verticalScroll = false
            //carousel.views = [button, button, button]
            return carousel
        } else {*/
            //return button
        //}
        let newsView = UITextView.init(x: 0, y: 0, w: 350, h: 100)
        newsView.text = "asdaskdlkalsdkalskdksldkasldkalskdlaksdlaksldksalkdl" +
        "asdklaskdlksaldkasldkalsdklaskdlaksdlksaldksaldksalkdlsakdlaskdlaskd" +
        "asdjajdkjsakdjaksdjksjdkajskdjaskjdkasjdkasjdkasjdkjasdjaksdjkasjdka"
        return newsView
    }
    func numberOfViews() -> Int {
        return 2
    }
    func numberOfVisibleViews() -> Int {
        return 1
    }
   /* public func updateView(view: UIView!, withProgress progress: CGFloat, scrollDirection direction: ScrollDirection) {
     
     }
     public func scrollView(scrollView: LTInfiniteScrollView!, didScrollToIndex index: Int) {
     
     }*/
    internal func setupScroll() {
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.clipsToBounds = true
        scrollView.verticalScroll = true
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.maxScrollDistance = 10
        scrollView.reloadDataWithInitialIndex(0)
        scrollSetupDone = true
    }
}
