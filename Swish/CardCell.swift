//
//  CardCell.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/24/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit

class CardCell: TisprCardStackViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    
    @IBOutlet var swishImageView: UIImageView!
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var dislikeImageView: UIImageView!
    
    var startingCenterY: CGFloat = -999;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12
        clipsToBounds = false
        
//        swishLabel.hidden = true
//        dislikeLabel.hidden = true
//        likeLabel.hidden = true
        
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
        
        if rotation > 10 {
            likeImageView.hidden = false
            dislikeImageView.hidden = true
            swishImageView.hidden = true
            
        } else if rotation < -10 {
            likeImageView.hidden = true
            dislikeImageView.hidden = false
            swishImageView.hidden = true
        
        } else {
        
            if (startingCenterY == -999) {
                startingCenterY = self.center.y
            }
            
            let diff = startingCenterY - self.center.y
            if (diff < -100) {
                swishImageView.hidden = false
                likeImageView.hidden = true
                dislikeImageView.hidden = true
                
            } else {
                swishImageView.hidden = true
                likeImageView.hidden = true
                dislikeImageView.hidden = true
            }
        }
    }
}

