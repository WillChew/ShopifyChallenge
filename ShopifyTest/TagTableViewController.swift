//
//  TagTableViewController.swift
//  ShopifyTest
//
//  Created by Will Chew on 2018-09-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

class TagTableViewController: UITableViewController {
    
    var networkManager: NetworkManager!
    var productsArray = [Product]()
    var tagsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = NetworkManager()
        networkManager.getProducts() { (productArr) in
            self.productsArray = productArr
            
            for product in self.productsArray {
                let words = product.tags.components(separatedBy: ", ")
                
                for word in words {
                    if self.tagsArray.contains(word) {

                    } else {
                        self.tagsArray.append(word)
                    }
                    
                    
                }
                
            }
           
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tagsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)
        cell.textLabel?.text = tagsArray[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToProductList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ProductsListPageTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            var newProductList = [Product]()
            destinationVC.selectedTag = tagsArray[indexPath.row]
            
            for product in productsArray {
                if product.tags.contains(tagsArray[indexPath.row]) {
                   newProductList.append(product)
                }
                destinationVC.productList = newProductList
            }
        }
    }
}
