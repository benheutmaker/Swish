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
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 12
        clipsToBounds = false
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
        var labelText = ""
        
        if rotation > 15 {
            label.textAlignment = NSTextAlignment.Left
            labelText = "Yay"
            
        } else if rotation < -15 {
            label.textAlignment = NSTextAlignment.Right
            labelText = "Boo!"
        } else {
            labelText = ""
        }
        
        label.text = labelText
    }
}

