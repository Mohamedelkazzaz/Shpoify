//
//  FavoritesViewController.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesViewModel = FavoritesViewModel()
    var favoriteProducts: [Favorites] = []
    
    @IBOutlet weak var emptywish: UIImageView!
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var noItemsLabel: UILabel!
    var favioriteArray = try! context.fetch(Favorites.fetchRequest())
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        DispatchQueue.main.async {
//            super.viewWillAppear(animated)
//            self.favoritesTableView.reloadData()
//            self.handleEmpty()
//        }
//        initViewModel()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        //favoriteProducts = CoreDataManager.shared.fetchData()
        favoriteProducts = try! context.fetch(Favorites.fetchRequest())
        favoritesTableView.reloadData()
    }
    
    func initView() {
        tableViewConfig()
        handleEmpty()
    }
    
    func initViewModel() {
       // favoriteProducts = CoreDataManager.shared.fetchData()
        favoriteProducts = try! context.fetch(Favorites.fetchRequest())
    }
    
    func tableViewConfig() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.rowHeight = 120
        favoritesTableView.tableHeaderView = nil
        favoritesTableView.tableFooterView = nil
        favoritesTableView.registerCellNib(cellClass: FavoritesCell.self)
    }
    
    func handleEmpty() {
        if  favioriteArray.isEmpty {
            favoritesTableView.isHidden = true
            emptywish.isHidden = false
        }
        else {
            favoritesTableView.isHidden = false
            emptywish.isHidden = true
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  favoriteProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeue() as FavoritesCell
        cell.setData(favorites: favoriteProducts[indexPath.row])
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius  = 20
        cell.clipsToBounds = true
        
        return cell
        
        
    }
}

// Mark: - TableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritesTableView.deselectRow(at: indexPath, animated: true)
        //    let favorites = favoritesViewModel.favoritesModel[indexPath.row]
        let vc = UIStoryboard(name: "ProductDetails", bundle: .main).instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
//        if editingStyle == .delete {
//            favoritesTableView.beginUpdates()
//            let product = favoritesViewModel.favoritesModel[indexPath.row]
//            //   self.favoritesViewModel.deleteFavoriteProducts(indexPath: product)
//            CoreDataManager.shared.delete(returnType: Favorites.self, delete: product)
//            CoreDataManager.shared.fetch(returnType: Favorites.self) { (history) in
//                self.favoritesViewModel.favoritesModel = history
//                self.handleEmpty()
//            }
//            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
//            favoritesTableView.endUpdates()
//        }
        CoreDataManager.shared.deleteProduct(Core: favoriteProducts[indexPath.row])
        favoriteProducts = CoreDataManager.shared.fetchDataFromFavorit()
        favoritesTableView.reloadData()
    }
}


