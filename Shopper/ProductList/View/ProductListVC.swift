//
//  ProductListVC.swift
//  Shopper

import UIKit


enum WishListType: String {
    case add, remove
    
    func getString() -> String {
        switch self {
        case .add:
            return "add"
        case .remove:
            return "remove"
        }
    }
}

/// This class will display the Product List
class ProductListVC: UIViewController {

///    This used to display the products in list view
    @IBOutlet var productListTableView: UITableView!
    
    fileprivate var viewModel: ProductListVM!

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureDefaultProductView()
    }


    //MARK: - Helper Methods
    
    /// Setting up the Controller/Views default cnofigurations
    private func configureDefaultProductView() {

        configireTableCell()
        self.viewModel = ProductListVM.init(delegate: self)
        viewModel.getProductList()
    }
    
    
    /// Configure tableView Cells
    private func configireTableCell() {
        let nib = UINib.init(nibName: ProductListCell.reuseIdentifier, bundle: nil)
        self.productListTableView.register(nib
            , forCellReuseIdentifier: ProductListCell.reuseIdentifier)
    }
    

}

//MARK: - TableView Delagtes and Datasources
extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: ProductListCell.reuseIdentifier) as? ProductListCell,
            let product = viewModel.productList?[indexPath.row] else {
            return ProductListCell()
        }
        let offerPriceStatus = viewModel.isOfferPriceAvailble(From: product)
        productCell.updateCellView(product, isOfferPriceAvail: offerPriceStatus)
        settingUpCellWishListActions(productCell, indexPath)
        return productCell
    }
}

//MARK: - TableView Cell ButtonActions/Helper Methods
extension ProductListVC {
    
    @objc func performWishListAction(_ sender: UIButton) {
        let index = sender.tag
        guard let identifier = sender.accessibilityIdentifier else { return }
        viewModel.updateProductWishList(index, wishListType: identifier)
    }
    
    /// Setup the cell button actions
    /// - Parameters:
    ///   - productCell: ProductList Cell
    ///   - indexPath: Selected cell IndexPath
    fileprivate func settingUpCellWishListActions(_ productCell: ProductListCell, _ indexPath: IndexPath) {
        ///Add Action
        productCell.addButton.tag = indexPath.row
        productCell.addButton.accessibilityIdentifier = WishListType.add.getString()
        productCell.addButton.addTarget(self, action: #selector(performWishListAction), for: .touchUpInside)
        ///Remove Action
        productCell.removeButton.tag = indexPath.row
        productCell.removeButton.accessibilityIdentifier = WishListType.remove.getString()
        productCell.removeButton.addTarget(self, action: #selector(performWishListAction), for: .touchUpInside)
    }

}

//MARK: - Product Viewmodel Delegates
extension ProductListVC: ProductListDelegate {
    
    func updateProductList() {
        DispatchQueue.main.async {
            self.productListTableView.reloadData()
        }
    }
}
