//
//  ViewController.swift
//  iFactory
//
//  Created by Bruno Garelli on 9/5/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   // @IBOutlet weak var theButton: AMKButton!
    //@IBOutlet weak var scrollView: AMKCarousel!
    
    @IBOutlet weak var amkTestLabel: AMKLabel!
    //var scrollView: LTInfiniteScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*scrollView = LTInfiniteScrollView(frame: CGRect(x: 0, y: 200, width: theButton.w, height: 100))*/
        
        //view.addSubview(scrollView)
        //theButton.addSubview(scrollView!)
        /*theButton.addBlock({
                print("blockExecuted")
            }, ForAction: 0)*/
        //let carruso = AMKCarousel.init(frame: CGRect.init(x: 100, y: 0, w: 350, h: 400))
        //carruso.storeID = "specialCarrousel"
        //carruso.scrollView.verticalScroll = false
        //view.addSubview(carruso)
        //boldMe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func boldMe() {
        let backUp = amkTestLabel.backStoreID
        if backUp.isEmpty {
            amkTestLabel.storeID = "sysBold"
        } else {
            amkTestLabel.storeID = backUp
        }
        amkTestLabel.reloadAMKConfig()
    }
    
    @objc func printaline(_ message: AnyObject) {
        print("GOOD JOB" + String(describing: message))
    }
    
    @objc func disablaline(_ message: AnyObject) {
        print("DISABLING" + String(describing: message))
    }
    
    @objc func enablaaline(_ message: AnyObject) {
        print("ENABLING" + String(describing: message))
    }
}
