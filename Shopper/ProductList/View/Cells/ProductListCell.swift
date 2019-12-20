//
//  ProductListCell.swift
//  Shopper
import UIKit

/// This is a cell component which have product list view
class ProductListCell: UITableViewCell {
    
    
    /// Properties and Constants
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var imageURL: ImageViewLoader!
    @IBOutlet private weak var price: UILabel!
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    /// It will update Cell view
    /// - Parameter value: Product - is Custom object which holds the product details
    func updateCellView(_ value: Product) {
        self.name.text = value.name
        updateOfferPrice(From: value)
        self.imageURL.setUpImageFrom(urlString: value.image, imageMode: .scaleAspectFit)
    }
    
    /// Update the price
    /// - Parameter value: Product - Custom object which holds the product info
    func updateOfferPrice(From value: Product) {
        var price = value.price
        var color = UIColor.gray
        
        if !value.offerPrice.isEmpty {
            price = value.offerPrice
            color = UIColor.red
        }
        self.price.text = price
        self.price.textColor = color
    }
}
