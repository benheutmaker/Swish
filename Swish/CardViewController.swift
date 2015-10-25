//
//  CardViewController.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/24/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit

class CardViewController: TisprCardStackViewController, TisprCardStackViewControllerDelegate {
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDemoProducts()
        setupCardLayout()
        
        registerForNotifications()
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
         print("card changed")
    }
    
    private func setupDemoProducts() {
        
        for var i: Int = 0; i < 6; i++ {
            let newProduct = Product(image: UIImage(named: "\(i + 1)")!)
            products.append(newProduct)
        }
    }
    
    override func numberOfCards() -> Int {
        return products.count
    }
    
    override func card(collectionView: UICollectionView, cardForItemAtIndexPath indexPath: NSIndexPath) -> TisprCardStackViewCell {
        let card = collectionView.dequeueReusableCellWithReuseIdentifier("Card", forIndexPath: indexPath) as! CardCell
        
        let product = products[indexPath.row]
        
        card.productImageView.image = product.image
        
        return card
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetCardStack() {
        setupDemoProducts()
        
        collectionView?.reloadData()
    }
    
    //NSNotificationCenter
    
    private func registerForNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetCardStack", name: resetCardStackNotification, object: nil)
    }
}

