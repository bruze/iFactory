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
    @IBOutlet weak var scrollView: AMKCarousel!
    
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
        //scrollView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func printaline(message: AnyObject) {
        print("GOOD JOB" + String(message))
    }
    
    @objc func disablaline(message: AnyObject) {
        print("DISABLING" + String(message))
    }
    
    @objc func enablaaline(message: AnyObject) {
        print("ENABLING" + String(message))
    }
}
