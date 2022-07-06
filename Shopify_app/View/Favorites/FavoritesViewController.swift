//
//  FavoritesViewController.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let favoritesViewModel = FavoritesViewModel()
    
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var noItemsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
            self.handleEmpty()
        }
        initViewModel()
    }
    
    func initView() {
        tableViewConfig()
        handleEmpty()
    }
    
    func initViewModel() {
        favoritesViewModel.getFavoriteProducts {favoriteProducts, error in
            guard let favoriteProducts = favoriteProducts else
            {   return  }
            self.favoritesViewModel.favoritesModel = favoriteProducts
            self.favoritesTableView.reloadData()
        }
    }
    
    func tableViewConfig() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.rowHeight = 80
        favoritesTableView.tableHeaderView = nil
        favoritesTableView.tableFooterView = nil
        favoritesTableView.registerCellNib(cellClass: FavoritesCell.self)
    }
    
    func handleEmpty() {
        if favoritesViewModel.favoritesModel.isEmpty {
            favoritesTableView.isHidden = true
            noItemsLabel.isHidden = false
        }
        else {
            favoritesTableView.isHidden = false
            noItemsLabel.isHidden = false
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesViewModel.favoritesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeue() as FavoritesCell
        cell.setData(favorites: favoritesViewModel.favoritesModel[indexPath.row])
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// Mark: - TableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritesTableView.deselectRow(at: indexPath, animated: true)
        let favorites = favoritesViewModel.favoritesModel[indexPath.row]
        let storyboard = UIStoryboard(name: "ProductDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            favoritesTableView.beginUpdates()
            favoritesViewModel.deleteFavoriteProducts(indexPath: indexPath)
            self.handleEmpty()
        }
        favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        favoritesTableView.endUpdates()
    }
}



