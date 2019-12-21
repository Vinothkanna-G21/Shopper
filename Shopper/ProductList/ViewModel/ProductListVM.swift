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
            self.updateWishList(data: products)
        }
    }
    
    /// Update the product wishlist from persistant data
    /// - Parameter data: [Product]
    func updateWishList(data: [Product]?) {
     
        self.productList = data

        if let productData = UserDefaults.standard.data(forKey: "kProductList"),
            let products = try? JSONDecoder().decode([Product].self, from: productData) {
            
            for product in products {
                self.productList?.filter({$0.pId == product.pId}).first?.quantity = product.quantity
            }
        }
    }
    
    /// Update Product Object with wishList data
    /// - Parameters:
    ///   - index: Product Object index
    ///   - wishListType: WishList Type
    func updateProductWishList(_ index: Int, wishListType: String) {
        
        guard var product = self.productList?[index] else {
            return
        }

        updateWishListQuantity(&product, wishListType: wishListType)
        self.productList?[index] = product
        CustomDefaults().persistData(productList ?? [])
    }
    
    /// Perform wishList actions
    /// - Parameter product: Product Object
     func updateWishListQuantity(_ product: inout Product, wishListType: String) {
        if wishListType == WishListType.add.getString() {
            if product.quantity >= 0 {
                
                product.quantity += 1
            }
            
        } else {
            if product.quantity > 0 {
                
                product.quantity -= 1
            }
        }
    }
    
    /// To check OfferPrice Available or not
    /// - Parameter value: Product - Custom object which holds the product info
    func isOfferPriceAvailble(From value: Product) -> Bool {
        
        if let _ = value.offerPrice {
            return true
        }
        return false
    }
    
    /// Get the product counts
    func getProductCount() -> Int {
        return productList?.count ?? 0
    }
}

class CustomDefaults {
    
    let userDefaults = UserDefaults.standard
    
    func persistData(_ values: [Product]) {
        
        let userDefaults = UserDefaults.standard
        
        do {
            let encoded = try JSONEncoder().encode(values)
            userDefaults.set(encoded, forKey: "kProductList")
            userDefaults.synchronize()
        }catch {
            print("Exception in Enoding")
        }
    }
}
