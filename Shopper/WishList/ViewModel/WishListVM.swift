//
//  WishListVM.swift
//  Shopper
//

import Foundation

protocol WishListUpdateDelegate {
    func updateWishListView()
}

class WishListVM {
 
    var delegate: WishListUpdateDelegate?
    
    var products: [Product]?
    
    var wishListData: WishList? {
        didSet {
            delegate?.updateWishListView()
        }
    }
    
    init(delegate: WishListUpdateDelegate) {
        self.delegate = delegate
    }
    
    func getWishListData() {
        
        let items = products?.filter{$0.quantity > 0}
        let savings = items?.map{Double($0.offerPrice ?? "") ?? 0.0}.reduce(0.0, +)
        let total = items?.map{Double($0.price ?? "") ?? 0.0}.reduce(0.0, +)
        wishListData = WishList.init(itemCount: items?.count ?? 0, savings: String(describing: savings), total: String(describing: total))
    }
}
