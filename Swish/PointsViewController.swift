//
//  PointsView.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/25/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit

class PointsViewController: UIViewController {

    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var sparkleImageView: UIImageView!
    
    func animateSparkleImage() {
        sparkleImageView.animationImages = sparkleImages
        sparkleImageView.animationRepeatCount = 1
        sparkleImageView.animationDuration = 1
        sparkleImageView.startAnimating()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
