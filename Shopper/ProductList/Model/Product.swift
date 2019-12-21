//
//  Product.swift
//  Shopper

import Foundation

/// It will holds the Product Model
class Product: NSObject, Codable {
    
    let pId: String?
    let name: String?
    let price: String?
    let image: String?
    let offerPrice: String?
    var quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case pId = "pid", name, price, image, offerPrice, quantity
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offerPrice = try values.decodeIfPresent(String.self, forKey: .offerPrice)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        quantity = try (values.decodeIfPresent(Int.self, forKey: .quantity) ?? 0)
        pId = try values.decodeIfPresent(String.self, forKey: .pId)
    }
    
    func encode(with acoder: NSCoder) {
       acoder.encode(name,forKey: "name")
       acoder.encode(image,forKey: "image")
        acoder.encode(price,forKey: "price")
        acoder.encode(offerPrice,forKey: "offerPrice")
        acoder.encode(quantity,forKey: "quantity")
        acoder.encode(pId,forKey: "pId")
    }
}
