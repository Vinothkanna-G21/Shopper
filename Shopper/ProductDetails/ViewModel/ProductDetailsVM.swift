//
//  ProductDetailsVM.swift
//  Shopper

import Foundation

protocol ProductDetailsUpdateDelegate {
    func updateProductDetailsPage()
}


class ProductDetailsVM {
    
    var product: Product?
    
    var delegate: ProductDetailsUpdateDelegate?
    
    init(delegate: ProductDetailsUpdateDelegate) {
        self.delegate = delegate
    }
    
    func updateProductDetails() {
        delegate?.updateProductDetailsPage()
    }
}
