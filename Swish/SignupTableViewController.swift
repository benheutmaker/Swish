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
        
        let paymentSummaryItems: [PKPaymentSummaryItem] = [
            PKPaymentSummaryItem(label: "Amount", amount: NSDecimalNumber(double: 25.00), type: PKPaymentSummaryItemType.Final),
            PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(double: 26.98), type: PKPaymentSummaryItemType.Final)
        ]
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        
        let chargeVC = SIMChargeCardViewController(publicKey: PUBLIC_PAYMENT_KEY, paymentRequest: paymentRequest)
        chargeVC.delegate = self
        
//        paymentRequest.shippingAddress
        
        self.presentViewController(chargeVC, animated: true, completion: nil)
    }
    
    //MARK: - SIMChargeCardViewControllerDelegate
    
    func chargeCardCancelled() {
        NSNotificationCenter.defaultCenter().postNotificationName(resetCardStackNotification, object: nil)
    }
    
    func creditCardTokenFailedWithError(error: NSError!) {
        
    }
    
    func creditCardTokenProcessed(token: SIMCreditCardToken!) {
        print(token.token)
        
        let alert = UIAlertController(title: "Confirmed", message: "Your item has successfully been purchased and on it's way!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default) { (action) -> Void in
            NSNotificationCenter.defaultCenter().postNotificationName(resetCardStackNotification, object: nil)
        }
        
        alert.addAction(okayAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
