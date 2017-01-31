//
//  AMKCarousel+Scroll.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/8/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit
import AssociatedValues

extension AMKCarousel: /*LTInfiniteScrollViewDataSource, LTInfiniteScrollViewDelegate*/InfiniteScrollDelegate, InfiniteScrollDataSource {
    var scrollView: /*LTInfiniteScrollView*/AMKInfiniteScroll {
        get {
            let newSize = Global.scaleRelativeToStandardSize(myStandardSize: bounds.size)
            let newBounds = CGRect.init(x: 0, y: 0, w: newSize.width, h: newSize.height)
            let scroll = getAssociatedValue(key: "scrollView", object: self, initialValue: AMKInfiniteScroll.init(frame: newBounds))
            scroll.showIndicator = showIndicator
            return scroll
        }
        set {
            set(associatedValue: newValue, key: "scrollView", object: self)
            scrollView.showIndicator = showIndicator
        }
    }
    //func viewAtIndex(index: Int, reusingView view: UIView?) -> UIView {
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
        /*if index < views?.count {
            return views![index]
        }
        let newsView = UITextView.init(x: 0, y: 0, w: 350, h: 100)
        newsView.text = "This is a placeholder view; soon AMKFactory will update views on IB"
        return newsView
    }*/
    func viewAtIndex(index: NSInteger, reusingView: UIView) -> UIView {
        if index < (views?.count)! {
            return views![index]
        }
        let newsView = UITextView.init(x: 0, y: 0, w: 350, h: 100)
        newsView.text = "This is a placeholder view; soon AMKFactory will update views on IB"
        return newsView
    }
    func numberOfViews() -> Int {
        let vcount = (views?.count)!
        return vcount
    }
    func numberOfVisibleViews() -> Int {
        return 1
    }
    func updateView(view: UIView, progress: CGFloat, scrollDirection: ScrollDirection) {
        lastScrollDirection = scrollDirection
        /*if !scrollView.endedScrolling {
            print("awaiting end scrolling")
        } else {
            print("")
        }*/
        if !indicatorJustUpdated && scrollView.startedScrolling && offsetSetupDone /*&& progress > 0.5*/ {
            indicatorJustUpdated = true
            /*if scrollDirection == .ScrollDirectionNext {
                currentIndicator += 1
            } else {
                currentIndicator -= 1
            }*/
            //currentIndicator = scrollView.currentIndex
            setNeedsDisplay()
        }
        setNeedsDisplay()
    }
    func scrollView(scrollView: AMKInfiniteScroll, didScrollToIndex: NSInteger) {
        //if !indicatorJustUpdated {
            //currentIndicator = didScrollToIndex + 1
            //currentIndicator = scrollView.currentIndex
            //setNeedsDisplay()
            /*indicatorJustUpdated = true
        } else {
            indicatorJustUpdated = false
        }*/
        if lastScrollDirection == .ScrollDirectionPrev {
            currentIndicator -= 1
        } else {
            currentIndicator += 1
        }
        setNeedsDisplay()
    }
    internal func setupScroll() {
        scrollView.backgroundColor = UIColor.clear
        scrollView.clipsToBounds = true
        scrollView.verticalScroll = verticalScroll
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.maxScrollDistance = 0
        scrollView.pagingEnabled = pagingEnabled
        //scrollView.reloadDataWithInitialIndex(0)
        scrollSetupDone = true
    }
}
