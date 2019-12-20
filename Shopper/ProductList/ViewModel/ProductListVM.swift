//
//  ProductListVM.swift
//  Shopper

import Foundation

protocol ProductListDelegate {
    func updateProductList()
}


/// Perform a ViewModel of ProductList Module
class ProductListVM {
    
    var productList: [Product]? {
        didSet {
            delegate?.updateProductList()
        }
    }
    private var delegate: ProductListDelegate?
    private var productService = ProductService()
    
    
    /// Initialize with delegate injection
    /// - Parameter delegate: Which delegate confirms the ProductList UI Updates
    init(delegate: ProductListDelegate) {
        
        self.delegate = delegate
    }
    
    
    /// Get ProductList
    func getProductList() {
        
        productService.getProductListFromServer { products in
            self.productList = products
        }
    }
}
