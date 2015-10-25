//
//  SignupTableViewController.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/24/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit
import PassKit

class SignupTableViewController: UIViewController, SIMChargeCardViewControllerDelegate {
    
    let PUBLIC_PAYMENT_KEY = (UIApplication.sharedApplication().delegate as! AppDelegate).PUBLIC_PAYMENT_KEY
    
    @IBAction func handlePaymentButtonPressed(sender: UIButton) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(hidePointLabelNotification, object: nil)
        
        let chargeVC = SIMChargeCardViewController(publicKey: PUBLIC_PAYMENT_KEY)
        chargeVC.delegate = self
        
        self.presentViewController(chargeVC, animated: true, completion: nil)
    }
    
    //MARK: - SIMChargeCardViewControllerDelegate
    
    func chargeCardCancelled() {
        NSNotificationCenter.defaultCenter().postNotificationName(resetCardStackNotification, object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName(hidePointLabelNotification, object: nil)
    }
    
    func creditCardTokenFailedWithError(error: NSError!) {
        NSNotificationCenter.defaultCenter().postNotificationName(hidePointLabelNotification, object: nil)
    }
    
    func creditCardTokenProcessed(token: SIMCreditCardToken!) {
        print(token.token)
        
        let alert = UIAlertController(title: "Congratulations", message: "That is gonna look gorgeous on you.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Thanks!", style: UIAlertActionStyle.Default) { (action) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(resetCardStackNotification, object: nil)
            NSNotificationCenter.defaultCenter().postNotificationName(hidePointLabelNotification, object: nil)
            NSNotificationCenter.defaultCenter().postNotificationName(add75PointsNotification, object: nil)
        }
        
        alert.addAction(okayAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
