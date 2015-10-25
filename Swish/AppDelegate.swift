//
//  AppDelegate.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/24/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit

let resetCardStackNotification = "resetCardStackNotification"

let add1PointNotification = "add1PointNotification"
let add5PointsNotification = "add5PointsNotification"
let add75PointsNotification = "add75PointsNotification"

let hidePointLabelNotification = "hidePointLabelNotification"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let PUBLIC_PAYMENT_KEY = "sbpb_NGJlMDZmMDMtMjRiYS00NmQ1LWI4NWYtN2Q1MGQ1NzY5MTcy"
    
    var points = 100
    var pointsView: PointsViewController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        setupPointsLabel()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "add1Point", name: add1PointNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "add5Points", name: add5PointsNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "add75Points", name: add75PointsNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "togglePointsViewHidden", name: hidePointLabelNotification, object: nil)
        
        pointsView.pointsLabel.text = "\(points)"
        
        return true
    }
    
    func add1Point() {
        ++points
        pointsView.pointsLabel.text = "\(points)"
        animateLabel(pointsView.pointsLabel)
        pointsView.animateSparkleImage()
    }
    
    func add5Points() {
        points += 5
        pointsView.pointsLabel.text = "\(points)"
        animateLabel(pointsView.pointsLabel)
        pointsView.animateSparkleImage()
    }
    
    func add75Points() {
        points += 75
        pointsView.pointsLabel.text = "\(points)"
        animateLabel(pointsView.pointsLabel)
        pointsView.animateSparkleImage()
    }
    
    func animateLabel(label: UILabel) {
        UIView.animateKeyframesWithDuration(1.0, delay: 0, options: UIViewKeyframeAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: { () -> Void in
                label.layer.transform = CATransform3DScale(label.layer.transform, 2, 2, 1)
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: { () -> Void in
                label.layer.transform = CATransform3DScale(label.layer.transform, 0.5, 0.5, 1)
            })
            }, completion: nil)
    }
    
    func togglePointsViewHidden() {
        if pointsView.pointsLabel.hidden == true {
            pointsView.pointsLabel.hidden = false
        } else {
            pointsView.pointsLabel.hidden = true
        }
    }

    private func setupPointsLabel() {
        pointsView = UINib(nibName: "PointsView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! PointsViewController
        
        pointsView.view.frame = CGRect(x: 0, y: 10, width: 75, height: 35)
        
        pointsView.view.clipsToBounds = false
        
        self.window?.addSubview(pointsView.view)
        
        pointsView.view.layer.zPosition = 1
        
        pointsView.pointsLabel.sizeToFit()
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}

