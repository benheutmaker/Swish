//
//  CardCell.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/24/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit

enum CardState {
    case In
    case Out
    case Swish
    case Idle
}

class CardCell: TisprCardStackViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var swishImageView: UIImageView!
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var dislikeImageView: UIImageView!
    
    @IBOutlet var productDescriptionLabel: UILabel!
    
    var startingCenterY: CGFloat = -999;
    
    var cardState = CardState.Idle
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        swishImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        swishImageView.layer.shadowOpacity = 0.3
        swishImageView.layer.shadowRadius = 6
        
        dislikeImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        dislikeImageView.layer.shadowOpacity = 0.3
        dislikeImageView.layer.shadowRadius = 6
        
        likeImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        likeImageView.layer.shadowOpacity = 0.3
        likeImageView.layer.shadowRadius = 6
    }
    
    override var center: CGPoint {
        didSet {
            updateSmileVote()
        }
    }
    
    override internal func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        updateSmileVote()
    }
    
    func updateSmileVote() {
        let rotation = atan2(transform.b, transform.a) * 100
        
        likeImageView.image = likeImageView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        dislikeImageView.image = dislikeImageView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        print(likeImageView.tintColor)
        
        if rotation > 7 {
            //Dislike
            likeImageView.hidden = false
            dislikeImageView.hidden = true
            swishImageView.hidden = true
            
            cardState = CardState.Out
            
        } else if rotation < -7 {
            likeImageView.hidden = true
            dislikeImageView.hidden = false
            swishImageView.hidden = true
            
            cardState = CardState.In
        
        } else {
        
            if (startingCenterY == -999) {
                startingCenterY = self.center.y
            }
            
            let diff = startingCenterY - self.center.y
            if (diff < -100) {
                swishImageView.hidden = false
                likeImageView.hidden = true
                dislikeImageView.hidden = true
                
                cardState = CardState.Swish
                
            } else {
                swishImageView.hidden = true
                likeImageView.hidden = true
                dislikeImageView.hidden = true
                
                cardState = CardState.Idle
            }
            
            print(self.cardState)
        }
    }
    
    
    
    
}
