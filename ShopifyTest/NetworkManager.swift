//
//  NetworkManager.swift
//  ShopifyTest
//
//  Created by Will Chew on 2018-09-21.
//  Copyright © 2018 Will Chew. All rights reserved.
//

import UIKit

enum Constants {
    static let page = "page"
    static let pageNum = "1"
    static let accessToken = "access_token"
    static let tokenValue = "c32313df0d0ef512ca64d5b336a0d7c6"
    static let authorization = "Authorization"
    static let headerValue = "Bearer QCsxzDpQvN4jHRQjPxszCt55RVndyUZI6sOQZ1xF_sHk_ewwXItiHEOxV3IoKOcsdbfNbnrBZbew8a2PLjf2qe0VRBou758RWt5PYJ5iQz8u3amGTSgQokeug1MtW3Yx"
}

class NetworkManager {
    
    
    func getProducts(completion: @escaping([Product]) -> ()) {
        var productArray = [Product]()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://shopicruit.myshopify.com")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.path = "/admin/products.json"
        
        let pageQueryItem = URLQueryItem(name: Constants.page, value: Constants.pageNum)
        let accessTokenQueryItem = URLQueryItem(name: Constants.accessToken, value: Constants.tokenValue)
        components.queryItems = [pageQueryItem, accessTokenQueryItem]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue(Constants.headerValue, forHTTPHeaderField: Constants.authorization)
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print(#line, "Success:\(statusCode)")
            } else if let error = error {
                print(#line, error.localizedDescription)
            }
            guard let data = data else { return }
            guard let jsonResult = try! JSONSerialization.jsonObject(with: data) as? Dictionary<String,Any?> else { return }
            let products = jsonResult["products"] as! Array<Dictionary<String,Any?>>
            
            for item in products {
                var totalStock = 0
                guard let stock = item["variants"] as? Array<Dictionary<String,Any?>>, let picture = item["image"] as? Dictionary<String, Any?>   else { return }
                let title = item["title"] as! String
                let tags = item["tags"] as! String
                let imageSource = picture["src"] as! String

                let pictureURL = URL(string: imageSource)!
                let imageData = try? Data(contentsOf: pictureURL)
                
                
                for inventoryStock in stock {
                   let stockNo = inventoryStock["inventory_quantity"] as! Int
                    totalStock += stockNo
                    
                }
                
                let newProduct = Product(tags: tags, name: title, stock: totalStock, image: UIImage(data:imageData!)!)
                productArray.append(newProduct)
                
            }
            completion(productArray)
            
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
}
