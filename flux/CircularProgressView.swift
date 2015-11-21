//
//  CircularProgressView.swift
//  flux
//
//  Created by Quach, Scott on 10/21/15.
//  Copyright © 2015 Hatch. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable


class CircularProgressView: UIView {
    
    var ringLayer: CAShapeLayer!
    var backgroundRingLayer: CAShapeLayer!
    
    var strokeColor = UIColor.orangeColor()

    
    var progress: Double = 0.6
    
    
    var lineWidth: CGFloat = 10.0
       
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

        
        if !(backgroundRingLayer != nil){
            backgroundRingLayer = CAShapeLayer()
            layer.addSublayer(backgroundRingLayer)
        
            let rect = CGRectInset(bounds, lineWidth/2.0, lineWidth/2.0)
            let path = UIBezierPath(ovalInRect: rect)
            
            backgroundRingLayer.path = path.CGPath
            backgroundRingLayer.fillColor = nil
            backgroundRingLayer.lineWidth = 15.0
            backgroundRingLayer.strokeColor = UIColor(white:0.5, alpha:0.3).CGColor
        
        }
        //outside temp if
            backgroundRingLayer.frame = layer.bounds
        
        if !(ringLayer != nil){
            ringLayer = CAShapeLayer()
            layer.addSublayer(backgroundRingLayer)
            
            let rect = CGRectInset(bounds, lineWidth/2.0, lineWidth/2.0)
            let path = UIBezierPath(ovalInRect: rect)
            
            ringLayer.path = path.CGPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = 15.0
            ringLayer.strokeColor = UIColor.orangeColor().CGColor
            ringLayer.anchorPoint = CGPointMake(0.5, 0.5)
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI/2), 0, 0, 1)
            
            layer.addSublayer(ringLayer)
            
        }
        
        ringLayer.frame = layer.bounds
        updateLayerProperties()

    }
    
    func updateLayerProperties() {
        if (ringLayer != nil) {
            
            
            var strokeColor = UIColor.orangeColor()
            
            
            //SAS starts 9:40 am
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day, .Hour, .Minute, .Second], fromDate: date)
            let hour = components.hour;
            let minute = components.minute;
            //        let second = components.second;
            print(String(hour))
            print(String(minute))
            //change text color depending on how long you have until SAS starts
            if minute <= 40{
                var untilMinute = 40 - minute
                untilMinute = 40 - untilMinute
                progress = Double(untilMinute)/40
                
                if untilMinute <= 5 {
                    strokeColor = UIColor.redColor()
                }else{
                   strokeColor = UIColor.greenColor()
                }
            }else{
                progress = 1.0
                strokeColor = UIColor.lightGrayColor()
            }
                
            

            
            
            
            
            ringLayer.strokeEnd = CGFloat(progress)
            ringLayer.strokeColor = strokeColor.CGColor
        }
    }
    
    
    
}
