//
//  ViewController.swift
//  Digital Clock
//
//  Created by Howard Ellenberger on 8/6/19.
//  Copyright © 2019 Howard Ellenberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var clockView: UIView!
    
    @IBOutlet weak var dateClock: UILabel!
    
    @IBOutlet weak var timeClock: UILabel!
    
    @IBOutlet weak var amPm: UILabel!
    
    var clockTimer: Timer?
    
    var dateTimer: Timer?
    
    var ampmTimer: Timer?
    
    let dateformatter = DateFormatter()
    
    @objc func pan(recognizer:UIPanGestureRecognizer){
        if recognizer.state == UIGestureRecognizer.State.changed || recognizer.state == UIGestureRecognizer.State.ended {
            let velocity:CGPoint = recognizer.velocity(in: self.view)
            
            if velocity.y > 0{
                var brightness: Float = Float(UIScreen.main.brightness)
                brightness = brightness - 0.015
                UIScreen.main.brightness = CGFloat(brightness)
                print("Decrease brigntness in pan")
            }
            else {
                var brightness: Float = Float(UIScreen.main.brightness)
                brightness = brightness + 0.015
                UIScreen.main.brightness = CGFloat(brightness)
                print("Increase brigntness in pan")
            }
        }
    }
    
    @objc func dateForClock() {
       
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "M.dd.yyyy"
        let date = dateformatter.string(from: Date())
        dateClock.text = date
    }
    
    @objc func timeForClock() {
        
        dateformatter.timeStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "h:mm"
        
        let time = dateformatter.string(from: Date())
        timeClock.text = time
    }
    
    @objc func amPmForClock() {
        
        dateformatter.dateStyle = DateFormatter.Style.short
        dateformatter.dateFormat = "a p"
        let ampm = dateformatter.string(from: Date())
        amPm.text = ampm
    }
    
    override func viewDidLoad() {
        super.viewDidLoad ()
    
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(pan(recognizer:)))
        panGesture.delegate = self as? UIGestureRecognizerDelegate
        panGesture.minimumNumberOfTouches = 1
        clockView.addGestureRecognizer(panGesture)
        
        clockTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(timeForClock), userInfo: nil, repeats: true)
        dateTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(dateForClock), userInfo: nil, repeats: true)
        ampmTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(amPmForClock), userInfo: nil, repeats: true)

        dateForClock()
        
        timeForClock()
        
        amPmForClock()
    }

}
