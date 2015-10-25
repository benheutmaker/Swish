//
//  Product.swift
//  Swish
//
//  Created by Benjamin Heutmaker on 10/24/15.
//  Copyright © 2015 Ben Heutmaker. All rights reserved.
//

import UIKit

class Product: NSObject {
    
    var imageString: String
    var price: Float
    var productDescription: String
    
    init(imageString: String, price: Float, productDescription: String) {
        self.imageString = imageString
        self.price = price
        self.productDescription = productDescription
    }
}