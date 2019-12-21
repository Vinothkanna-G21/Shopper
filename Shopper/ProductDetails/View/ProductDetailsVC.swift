//
//  ProductDetailsVC.swift
//  Shopper

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet private weak var productImageView: ImageViewLoader!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var productPrice: UILabel!

    var viewModel: ProductDetailsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.updateProductDetails()
    }
}

extension ProductDetailsVC: ProductDetailsUpdateDelegate {
    
    func updateProductDetailsPage() {
        
        guard let value = viewModel.product else {return }
        
        self.productName.text = value.name
        self.productPrice.text = value.price
        self.productImageView.setUpImageFrom(urlString: value.image ?? "", imageMode: .scaleAspectFit)
    }
}
