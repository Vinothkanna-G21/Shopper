//
//  ProductService.swift
//  Shopper

import Foundation

/// This class will do Product delated Sevices
class ProductService {
    
    
    /// Will return the URL of  Product List
    func getProductListUrl() -> URL? {
        
        guard let url = URL.init(string: "http://www.mocky.io/v2/5dfb59e72f00006200ff9e80") else {
            return nil
        }
        return url
    }
    
    /// - To get the Product list fro server
    /// - Parameter productListCompletion: Will returns the Array of Product object
    func getProductListFromServer(productListCompletion: @escaping ([Product]?) -> Void) {
        
        guard let url = getProductListUrl() else {
            return
        }
        
        WebServiceManager.performGetMethod(url: url) { (jsonData) in
    
            let jsonDecoder = JSONDecoder()
            let products = try? jsonDecoder.decode([Product].self, from: jsonData)
            productListCompletion(products)
        }
    }
}
