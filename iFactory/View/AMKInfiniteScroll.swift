//
//  AMKInfiniteScroll.swift
//  e2e
//
//  Created by Bruno Garelli on 12/27/16.
//  Copyright © 2016 Altimetrik. All rights reserved.
//

import Foundation
import UIKit
@objc enum ScrollDirection: NSInteger {
    case ScrollDirectionNext = 0
    case ScrollDirectionPrev = 1
}

@objc protocol InfiniteScrollDelegate: NSObjectProtocol {
    @objc func updateView(view: UIView, progress: CGFloat, scrollDirection: ScrollDirection)
    func scrollView(scrollView: AMKInfiniteScroll, didScrollToIndex: NSInteger)
}

protocol InfiniteScrollDataSource {
    func viewAtIndex(index: NSInteger, reusingView: UIView) -> UIView
    /*var numberOfViews: NSInteger {get set}
    var numberOfVisibleViews: NSInteger {get set}*/
    func numberOfViews() -> NSInteger
    func numberOfVisibleViews() -> NSInteger
}

class AMKInfiniteScroll: UIView, UIScrollViewDelegate {
    var offsetTrick = false
    var currentIndex: NSInteger = -1
    var dataSource: InfiniteScrollDataSource? = nil
    var delegate: InfiniteScrollDelegate? = nil
    var verticalScroll = false
    var startedScrolling = false
    var endedScrolling = false
    var showIndicator = true
    var viewPointsIndicator = 0
    var indicatorColor = UIColor.clear
    var scrollEnabled: Bool {
        /*get {return self.scrollEnabled}
        set {self.scrollEnabled = newValue
            scrollView?.scrollEnabled = scrollEnabled
            }*/
        didSet {
            scrollView?.isScrollEnabled = scrollEnabled
        }
    }
    var pagingEnabled: Bool {
        /*get {return self.pagingEnabled}
        set {self.pagingEnabled = newValue
            scrollView?.pagingEnabled = pagingEnabled
            }*/
        didSet {
            scrollView?.isPagingEnabled = pagingEnabled
        }
    }
    var bounces: Bool {
        /*get {return self.bounces}
        set {self.bounces = newValue
            scrollView?.bounces = bounces
            }*/
        didSet {
            scrollView?.bounces = bounces
        }
    }
    var contentInset: UIEdgeInsets {
        /*get {return self.contentInset}
        set {self.contentInset = newValue
            scrollView?.contentInset = contentInset
            }*/
        didSet {
            scrollView?.contentInset = contentInset
        }
    }
    var maxScrollDistance: NSInteger = 0
    
    var offset = false
    var scrollView: UIScrollView? = nil
    var viewSize = CGFloat.init(0)
    var visibleViewCount: NSInteger = 0
    var totalViewCount: NSInteger = 0
    var previousPosition = CGFloat.init(0)
    var totalSize = CGFloat.init(0)
    var scrollDirection: ScrollDirection = .ScrollDirectionPrev
    var views: [NSInteger: UIView] = [:]
    
    var scrollViewSize: CGFloat {
        get {
            return self.verticalScroll ? self.bounds.size.height : self.bounds.size.width
        }
    }
    var scrollViewContentSize: CGFloat {
        get {
            let size = (self.scrollView?.contentSize)!
            return self.verticalScroll ? size.height : size.width
        }
    }
    var scrollPosition: CGFloat {
        get {
            let pos = (self.scrollView?.contentOffset)!
            return self.verticalScroll ? pos.y : pos.x
        }
    }
    
    var allViews: Array<UIView> {
        get {
            return Array(self.views.values)
        }
    }
    
    override init(frame: CGRect) {
        self.scrollEnabled = true
        self.pagingEnabled = false
        self.bounces = false
        self.contentInset = UIEdgeInsets.init()
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.scrollEnabled = true
        self.pagingEnabled = false
        self.bounces = false
        self.contentInset = UIEdgeInsets.init()
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, w: self.bounds.width, h: self.bounds.height))
        self.scrollView!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.scrollView!.showsHorizontalScrollIndicator = false
        self.scrollView!.showsVerticalScrollIndicator = false
        self.scrollView!.delegate = self
        self.scrollView!.clipsToBounds = false
        self.scrollView!.isPagingEnabled = self.pagingEnabled
        addSubview(scrollView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView!.frame = self.bounds
        let index = self.currentIndex
        updateSize()
        if self.views.count == 0 {
            return
        }
        for view in self.views.values {
            view.center = centerForViewAtIndex(index: view.tag)
        }
        scrollToIndex(index: index, animated: false)
    }
    func reloadDataWithInitialIndex(initialIndex: NSInteger) {
        for view in (scrollView?.subviews)! {
            view.removeFromSuperview()
        }
        self.views = [:]
        self.visibleViewCount = dataSource!.numberOfVisibleViews()
        self.totalViewCount = dataSource!.numberOfViews()
        
        updateSize()
        self.currentIndex = initialIndex
        scrollView?.contentOffset = contentOffsetForIndex(index: self.currentIndex)
        reArrangeViews()
        updateProgress()
    }
    func scrollToIndex(index: NSInteger, animated: Bool) {
        if index < self.currentIndex {
            self.scrollDirection = .ScrollDirectionPrev
        } else {
            self.scrollDirection = .ScrollDirectionNext
        }
        scrollView?.setContentOffset(contentOffsetForIndex(index: index), animated: animated)
    }
    func viewAtIndex(index: NSInteger) -> UIView {
        return self.views[index]!
    }
    
    private func updateSize() {
        self.viewSize = self.scrollViewSize / CGFloat(self.visibleViewCount)
        self.totalSize = self.viewSize * CGFloat(self.totalViewCount)
        if self.verticalScroll {
            self.scrollView?.contentSize = CGSize.init(width: self.bounds.width, height: self.totalSize)
        } else {
            self.scrollView?.contentSize = CGSize.init(width: self.totalSize, height: self.bounds.height)
        }
    }
    func reArrangeViews() {
        var indexesNeeded: Set<NSInteger> = []
        let toCeil = CGFloat(self.visibleViewCount) / 2.0
        let begin = NSInteger(CGFloat(self.currentIndex) - ceil(toCeil))
        let end = NSInteger(CGFloat(self.currentIndex) + ceil(toCeil))
        
        for i in begin...end {
            if i < 0 {
                let index = end - i
                if index < self.totalViewCount {
                    indexesNeeded.insert(index)
                }
            } else if i >= self.totalViewCount {
                let index = begin - i
                if index >= 0 {
                    indexesNeeded.insert(index)
                }
            } else {
                indexesNeeded.insert(i)
            }
            for indexNeeded in indexesNeeded {
                var view = self.views[indexNeeded]
                if (view != nil) {
                    continue
                } else {
                    view = UIView.init()
                }
                for index in self.views.keys {
                    if !indexesNeeded.contains(index) {
                        view = self.views[index]
                        self.views.removeValue(forKey: index)
                        break
                    }
                }
                view = self.dataSource?.viewAtIndex(index: indexNeeded, reusingView: view!)
                view?.removeFromSuperview()
                view!.tag = indexNeeded
                view!.center = centerForViewAtIndex(index: indexNeeded)
                self.views[indexNeeded] = view
                self.scrollView?.addSubview(view!)
            }
        }
        setNeedsDisplay()
    }
    func updateProgress() {
        if !self.delegate!.responds(to: #selector(InfiniteScrollDelegate.updateView(view:progress:scrollDirection:))) {
            return
        }
        let center = currentCenter()
        //let tallViews =  allViews
        for view in allViews {
            var progress: CGFloat = 0
            if verticalScroll {
                progress = (view.center.y - center) / self.bounds.height * CGFloat(self.visibleViewCount)
            } else {
                progress = (view.center.x - center) / self.bounds.width * CGFloat(self.visibleViewCount)
            }
            self.delegate?.updateView(view: view, progress: progress, scrollDirection: self.scrollDirection)
        }
    }
    func didScrollToIndex(index: NSInteger) {
        if self.delegate!.responds(to: #selector(InfiniteScrollDelegate.scrollView(scrollView:didScrollToIndex:))) {
            self.delegate!.scrollView(scrollView: self, didScrollToIndex: self.currentIndex)
        }
    }
    //MARK: ScrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //let currentCenter = currentCenter()
        startedScrolling = true
        endedScrolling = false
        let offset = scrollPosition
        
        self.currentIndex = Int(round((currentCenter() - self.viewSize / 2) / self.viewSize))
        if offset > self.previousPosition {
            self.scrollDirection = .ScrollDirectionNext
        } else {
            self.scrollDirection = .ScrollDirectionPrev
        }
        self.previousPosition = offset
        
        reArrangeViews()
        updateProgress()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        endedScrolling = true
        if !self.pagingEnabled /*&& !decelerate && self.needsCenterPage()*/ {
            let offset = scrollPosition
            if offset < 0 || offset > self.scrollViewContentSize {
                return
            }
            self.scrollView?.setContentOffset(contentOffsetForIndex(index: self.currentIndex), animated: true)
            didScrollToIndex(index: self.currentIndex)
        } else {
            if offsetTrick {
                if let parent = self.delegate as? AMKCarousel {
                    parent.currentIndicator = currentIndex + 1
                }
            }
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if !self.pagingEnabled && self.needsCenterPage() {
            self.scrollView?.setContentOffset(contentOffsetForIndex(index: self.currentIndex), animated: true)
        }
    }
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: inout UnsafeMutablePointer<CGPoint>) {
        if self.maxScrollDistance <= 0 {
            return
        }
        if !self.needsCenterPage() {
            return
        }
        let target = self.verticalScroll ? targetContentOffset.pointee.y : targetContentOffset.pointee.x
        let contentOffset = contentOffsetForIndex(index: self.currentIndex)
        let current = self.verticalScroll ? contentOffset.y : contentOffset.x
        if fabs(target - current) <= self.viewSize / 2 {
            return
        } else {
            let distance = self.maxScrollDistance - 1
            let currentIndex = self.currentIndex
            let targetIndex = self.scrollDirection == .ScrollDirectionNext ? currentIndex + distance : currentIndex - distance
            let targetOffset = contentOffsetForIndex(index: targetIndex)
            if self.verticalScroll {
                targetContentOffset.pointee.y = targetOffset.y
            } else {
                targetContentOffset.pointee.x = targetOffset.x
            }
        }
    }
    //MARK: Helper Methods
    func needsCenterPage() -> Bool {
        let pos = self.scrollPosition
        if pos < 0 || pos > self.scrollViewContentSize - self.viewSize {
            return false
        } else {
            return true
        }
    }
    func currentCenter() -> CGFloat {
        return self.scrollPosition + self.scrollViewSize / 2.0
    }
    func contentOffsetForIndex(index: NSInteger) -> CGPoint {
        let point = centerForViewAtIndex(index: index)
        
        let center = self.verticalScroll ? point.y : point.x
        var position = center - self.scrollViewSize / 2.0
        position = max(0, position)
        position = min(position, self.scrollViewContentSize)
        if self.verticalScroll {
            return CGPoint.init(x: 0, y: position)
        } else {
            return CGPoint.init(x: position, y: 0)
        }
    }
    func centerForViewAtIndex(index: NSInteger) -> CGPoint {
        var xoffset: CGFloat = 0
        if (UI_USER_INTERFACE_IDIOM() == .pad) {
            xoffset = 0
            /*if self.currentIndex > 0 {
                xoffset = -30
            }*/
        } else {
            if offsetTrick {
                let screenSize = UIScreen.main.bounds
                if screenSize.height < 667 {
                    xoffset = 60
                } else {
                    xoffset = 70
                    if self.offset && self.currentIndex > 0 {
                        xoffset = 90
                    }
                }
            }
        }
        let pos = CGFloat(index) * (self.viewSize - xoffset) + self.viewSize / 2
        if self.verticalScroll {
            return CGPoint.init(x: self.bounds.midX, y: pos)
        } else {
            return CGPoint.init(x: pos, y: self.bounds.midY)
        }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        ////////////////////
        if !showIndicator { return }
        ////////////////////
        let screenSize = UIScreen.main.bounds
        let iPadSize = screenSize.height >= 1024
        let iSmallSize = screenSize.height < 768
        var tW = CGFloat(6)
        var tH = CGFloat(6)
        var separation = CGFloat(10)
        if iPadSize {
            tW = 12
            tH = 12
            //separation = 15
        }
        let increment = separation + tW
        let tSize = CGSize.init(width: tW, height: tH)
        let originX = ((CGFloat(viewPointsIndicator) * tW) + (CGFloat(viewPointsIndicator - 1) * separation)) / 2
        var setY = h - increment
        if iPadSize && size.height > 350 {
            setY = h - (2 * increment)
        } else if iSmallSize {
            if size.height > 150 {
                setY = h - increment - 10
            }
        }
        var iOrigin = CGPoint.init(x: w / 2 - originX, y: setY)
        if viewPointsIndicator > 0 {
            for index in 1...viewPointsIndicator {
                if index == currentIndex + 1 {
                    if indicatorColor != UIColor.clear {
                        indicatorColor.setFill()
                    } else {
                        UIColor.orange.setFill()
                    }
                } else {
                    UIColor.gray.setFill()
                }
                let path = UIBezierPath.init(ovalIn: CGRect.init(origin: iOrigin, size: tSize))
                path.fill()
                iOrigin.x += increment
            }
        }
    }
}
