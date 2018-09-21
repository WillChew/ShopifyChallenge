//
//  Product.swift
//  ShopifyTest
//
//  Created by Will Chew on 2018-09-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class Product {
    var tags : String
    var name : String
    var stock : Int
    var image : UIImage
    
    init(tags: String, name: String, stock: Int, image: UIImage) {
        self.tags = tags
        self.name = name
        self.stock = stock
        self.image = image
    }
}
