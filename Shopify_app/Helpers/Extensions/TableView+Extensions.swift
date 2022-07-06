//
//  TableView+Extensions.swift
//  Shopify_app
//
//  Created by Ahmad Ashraf on 06/07/2022.
//

import UIKit

extension UITableView {
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell identifier")
        }
        return cell
    }
}
