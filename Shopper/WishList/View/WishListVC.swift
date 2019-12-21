//
//  WishListVC.swift
//  Shopper

import UIKit

class WishListVC: UIViewController {

    @IBOutlet weak var savings: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    
    var wishListProduct: WishListVM?
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wishListProduct?.getWishListData()
    }
    
    //MARK: - Button Actions
    @IBAction func navigateToProductList(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func wishListAction(_ sender: UIButton) {
        
    }
}

extension WishListVC: WishListUpdateDelegate {
    
    func updateWishListView() {
        
        guard let values = wishListProduct?.wishListData else {
            return
        }
        
        self.savings.text = values.savings
        self.itemCount.text = String(describing: values.items)
        self.total.text = values.total
    }
}
