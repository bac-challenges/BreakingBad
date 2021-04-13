//
//  UITableView.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) {
        let identifier = String(describing: T.self)
        register(T.self, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Cell indentifier not found for: \(identifier)")
        }
        
        return cell
    }
}
