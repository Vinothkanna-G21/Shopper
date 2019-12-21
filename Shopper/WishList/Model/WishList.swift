//
//  WishList.swift
//  Shopper

import Foundation

struct WishList {
    let items: Int?
    let savings: String?
    let total: String?
    
    init(itemCount: Int, savings: String, total: String) {
        self.items = itemCount
        self.savings = savings
        self.total = total
    }
}
