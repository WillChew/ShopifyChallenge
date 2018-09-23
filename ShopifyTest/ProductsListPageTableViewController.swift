//
//  ProductsListPageTableViewController.swift
//  ShopifyTest
//
//  Created by Will Chew on 2018-09-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class ProductsListPageTableViewController: UITableViewController {
    
    var selectedTag: String!
    var productList: [Product]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = selectedTag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return productList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsList", for: indexPath)

        cell.textLabel?.text = productList[indexPath.row].name
        cell.detailTextLabel?.text = String(productList[indexPath.row].stock)
        cell.imageView?.image = productList[indexPath.row].image

        return cell
    }

}
