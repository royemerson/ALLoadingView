//
//  ViewController.swift
//  ALLoadingView
//
//  Created by Артем Логинов on 13.09.15.
//  Copyright (c) 2015 ALoginov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var step: Int = 0
    private var updateTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func action_testCaseOne(sender: AnyObject) {
        if step == 0 {
            print("Present")
            ALLoadingView.manager.windowRatio = 0.6
            ALLoadingView.manager.showLoadingViewOfType(.MessageWithIndicator, windowMode: ALLVWindowMode.Windowed, completionBlock: nil)
        }
        
        if step == 1 {
            print("Update value 1")
            ALLoadingView.manager.updateMessageLabelWithText("Shoo-shoo")
        }
        
        if step == 2 {
            print("Update value 2")
            ALLoadingView.manager.updateMessageLabelWithText("SHANA-shoo")
        }
        
        if step == 3 {
            print("Update value 3")
            ALLoadingView.manager.updateMessageLabelWithText("AOSIJAOSJFLAKJS-shoo")
        }
        
        if step == 4 {
            print("Close")
            ALLoadingView.manager.hideLoadingView()
            step = -1
        }
        
        step++
    }
    
    @IBAction func action_testCaseTwo(sender: AnyObject) {
        ALLoadingView.manager.bluredBackground = true
        NSLog("Push")
        ALLoadingView.manager.showLoadingViewOfType(.MessageWithIndicatorAndCancelButton, windowMode: ALLVWindowMode.Fullsreen, completionBlock: nil)
        ALLoadingView.manager.hideLoadingViewWithDelay(3.0)
//        let justView = UIView(frame: self.view.bounds)
//        justView.backgroundColor = .clearColor()
//        let blurEffect = UIBlurEffect(style: .Light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = justView.bounds
//        view.addSubview(blurEffectView)
    }
    
    @IBAction func action_testCaseThree(sender: AnyObject) {
        ALLoadingView.manager.bluredBackground = true
        ALLoadingView.manager.showLoadingViewOfType(.MessageWithIndicatorAndCancelButton, windowMode: ALLVWindowMode.Fullsreen, completionBlock: nil)
        ALLoadingView.manager.cancelCallback = {
            ALLoadingView.manager.hideLoadingView()
        }
    }
    
    @IBAction func action_testCaseFour(sender: AnyObject) {
        step = 0
        ALLoadingView.manager.showLoadingViewOfType(.Progress) {
            (finished) -> Void in
            ALLoadingView.manager.updateProgressLoadingViewWithMessage("Initializing", forProgress: 0.05)
            self.step = 1
            self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
        }
    }
    
    func updateProgress() {
        let steps = ["Initializing", "Downloading data", "Extracting files", "Parsing data", "Updating database", "Saving"]
        ALLoadingView.manager.updateProgressLoadingViewWithMessage(steps[step], forProgress: 0.2 * Float(step))
        step++
        if step == steps.count {
            updateTimer.invalidate()
        }
    }
}

