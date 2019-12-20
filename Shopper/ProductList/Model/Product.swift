//
//  Product.swift
//  Shopper

import Foundation

/// It will holds the Product Model
struct Product: Codable {
    
    public private(set) var name: String
    public private(set) var price: String
    public private(set) var image: String
    public private(set) var offerPrice: String
}
