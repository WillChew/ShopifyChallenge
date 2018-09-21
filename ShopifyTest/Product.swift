//
//  Product.swift
//  ShopifyTest
//
//  Created by Will Chew on 2018-09-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import Foundation

class Product {
    var tags : String
    var name : String
    var stock : Int
    
    init(tags: String, name: String, stock: Int) {
        self.tags = tags
        self.name = name
        self.stock = stock
    }
}
