//
//  ProductListVC.swift
//  Shopper

import UIKit

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
        return viewModel.productList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: ProductListCell.reuseIdentifier) as? ProductListCell,
            let product = viewModel.productList?[indexPath.row] else {
            return ProductListCell()
        }
        
        productCell.updateCellView(product)
        return productCell
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
