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
    }
    
    private func setupCardLayout() {
        
        layout.topStackMaximumSize = 4
        layout.bottomStackCardHeight = 0
        layout.bottomStackMaximumSize = 0
        
        cardStackDelegate = self
        
        let cardSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 44)
        
        setAnimationSpeed(0.85)
        setCardSize(cardSize)
    }
    
    func cardDidChangeState(cardIndex: Int) {
         print("card changed")
    }
    
    private func setupDemoProducts() {
        let dressImage = UIImage(named: "dress")!
        
        for var i = 0; i < 25; i++ {
            let newProduct = Product(image: dressImage)
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


}

