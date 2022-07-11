//
//  CartsViewController.swift
//  Shopify_app
//
//  Created by Mohamed Elkazzaz on 01/07/2022.
//

import UIKit

class CartsViewController: UIViewController {
    @IBOutlet weak var cardsTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var checkOutView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    var cart : [Cart] = []
    let orderViewModel = OrderViewModel()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        setTotalPrice()
        checkCart()
        setCartItems()
        cardsTableView.delegate = self
        cardsTableView.dataSource = self

        cardsTableView.register(UINib(nibName: "CartsCell", bundle: nil), forCellReuseIdentifier: "cartCell")
        
    }
    
   
    func setTotalPrice(){
        orderViewModel.calcTotalPrice { totalPrice in
            guard let totalPrice = totalPrice else { return }
            ApplicationUserManger.shared.setTotalPrice(totalPrice:totalPrice)
            self.priceLabel.text = String(totalPrice) + " USD"
        }
    }
    
    func checkCart(){
        if cart.count == 0 {
            cardsTableView.isHidden = true
            checkOutView.isHidden = true
            emptyView.isHidden = false
        }else{
            emptyView.isHidden = true
            cardsTableView.isHidden = false
            checkOutView.isHidden = false
        }
    }
    
    func setCartItems(){
        orderViewModel.getSelectedProducts { orders, error in
            guard let orders = orders else {return}
            self.cart = orders
            self.cardsTableView.reloadData()
        }
    }

    
    @IBAction func checkOutButton(_ sender: UIButton) {
        if cart.count != 0 {
            let storyBoard = UIStoryboard(name: "Adress", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AddressViewController") as!AddressViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "There is no items in cart.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension CartsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartsCell
        cell.setup(cart: cart[indexPath.row])
        
        cell.addItemQuantity = {
            self.orderViewModel.getSelectedItemInCart(productId: self.cart[indexPath.row].id) { selectedOrder, error in
                if selectedOrder != nil {
                    selectedOrder?.quantity+=1
                }
                self.orderViewModel.saveProductToCart()
            }
            self.cardsTableView.reloadData()
            self.setTotalPrice()
        }
        
        cell.subItemQuantity = {
            if self.cart[indexPath.row].quantity > 1 {
                self.orderViewModel.getSelectedItemInCart(productId: self.cart[indexPath.row].id) { selectedOrder, error in
                    if selectedOrder != nil {
                        selectedOrder?.quantity-=1
                    }
                    self.orderViewModel.saveProductToCart()
                }
            }
            self.cardsTableView.reloadData()
            self.setTotalPrice()
        }
        
        
        cell.quantityNumberLabel.text = String(cart[indexPath.row].quantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Delete(indexPath: indexPath)
    }
    
    
    func Delete(indexPath:IndexPath){
        let alert = UIAlertController(title: "Are you sure?", message: "You will remove this item from the cart", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] UIAlertAction in
            orderViewModel.deleteFromCoreData(indexPath: indexPath, cartItems: cart)
            self.cart.remove(at: indexPath.row)
            cardsTableView.deleteRows(at: [indexPath], with: .left)
            self.cardsTableView.reloadData()
            if self.cart.count == 0 {
                emptyView.isHidden = false
                self.cardsTableView.isHidden = true
                self.cardsTableView.reloadData()
                setTotalPrice()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
  }
}
