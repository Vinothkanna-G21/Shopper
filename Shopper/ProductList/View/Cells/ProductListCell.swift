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
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    /// It will update Cell view
    /// - Parameter value: Product - is Custom object which holds the product details
    func updateCellView(_ value: Product, isOfferPriceAvail: Bool) {
        self.name.text = value.name
        self.quantityLabel.text = "\(value.quantity)"
        self.price.text = isOfferPriceAvail ? value.offerPrice: value.price
        self.price.textColor = isOfferPriceAvail ? UIColor.red: UIColor.gray
        self.imageURL.setUpImageFrom(urlString: value.image ?? "", imageMode: .scaleAspectFit)
    }
}
