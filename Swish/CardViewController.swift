//
//  CardViewController.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/24/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit
import Social

class CardViewController: TisprCardStackViewController, TisprCardStackViewControllerDelegate, GHContextOverlayViewDataSource, GHContextOverlayViewDelegate {
    
    var products: [Product] = []
    
    var longPress: UILongPressGestureRecognizer!
    
    var overlayMenu = GHContextMenuView()
    
    var currentCard = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        products += allProducts
        setupCardLayout()
        
        registerForNotifications()
        
        longPress = UILongPressGestureRecognizer(target: overlayMenu, action: "longPressDetected:")
        longPress.delaysTouchesBegan = true
        longPress.minimumPressDuration = 0.5
        
        collectionView?.addGestureRecognizer(longPress)
        
        overlayMenu.dataSource = self
        overlayMenu.delegate = self
    }
    
    func numberOfMenuItems() -> Int {
        return 4
    }
    
    func imageForItemAtIndex(index: Int) -> UIImage! {
        switch index {
        case 0: return UIImage(named: "twitter")!
        case 1: return UIImage(named: "facebook")!
        case 2: return UIImage(named: "instagram")!
        case 3: return UIImage(named: "email")!
        default: return nil
        }
    }
    
    func didSelectItemAtIndex(selectedIndex: Int, forMenuAtPoint point: CGPoint) {
        if selectedIndex == 0 {
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let tweetSheet  = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetSheet.setInitialText("I love these clothes! #SoSwish @App_Swish")
                tweetSheet.addImage(UIImage(named: "\(currentCard + 1)"))
                self.presentViewController(tweetSheet, animated: true, completion: { () -> Void in
                    NSNotificationCenter.defaultCenter().postNotificationName(add5PointsNotification, object: nil)
                })

            } else {
                let alert = UIAlertController(title: "No Twitter account set up", message: "Please head over to settings and connect a Twitter account!", preferredStyle: UIAlertControllerStyle.Alert)
                let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(okayAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupCardLayout() {
        
        layout.topStackMaximumSize = 4
        layout.bottomStackCardHeight = 0
        layout.bottomStackMaximumSize = 0
        
        cardStackDelegate = self
        
        layout.disableSwipeRecognizerDown()
        layout.disableSwipeRecognizerUp()
        
        let cardSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        setAnimationSpeed(0.85)
        setCardSize(cardSize)
    }
    
    func cardDidChangeState(cardIndex: Int) {
        currentCard++
        
        NSNotificationCenter.defaultCenter().postNotificationName(add1PointNotification, object: nil)
    }
    
    override func numberOfCards() -> Int {
        return products.count
    }
    
    override func card(collectionView: UICollectionView, cardForItemAtIndexPath indexPath: NSIndexPath) -> TisprCardStackViewCell {
        let card = collectionView.dequeueReusableCellWithReuseIdentifier("Card", forIndexPath: indexPath) as! CardCell
        
        let product = products[indexPath.row]
        
        card.productImageView.image = UIImage(named: product.imageString)
        card.productDescriptionLabel.text = product.productDescription
        
        return card
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetCardStack() {
        self.products += allProducts
        collectionView?.reloadData()
        currentCard = 0
    }
    
    //NSNotificationCenter
    
    private func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetCardStack", name: resetCardStackNotification, object: nil)
    }
}

