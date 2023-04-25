//
//  UITableView+Extensions.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import UIKit

extension UITableView {
    
    public static let hiddenSeparatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    
    public func register(cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.identifier)
    }
    
    public func register(headerFooterType: UITableViewHeaderFooterView.Type) {
        register(headerFooterType, forHeaderFooterViewReuseIdentifier: headerFooterType.identifier)
    }
    
    public func dequeue<Element: UITableViewCell>(cellType: Element.Type, for indexPath: IndexPath) -> Element {
        let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        
        guard let element = cell as? Element else {
            fatalError("Cell \(cell) cannot be casted as \(cellType.identifier)")
        }
        
        return element
    }
    
    public func dequeue<Element: UITableViewHeaderFooterView>(headerFooterType: Element.Type) -> Element {
        let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: headerFooterType.identifier)
        
        guard let element = headerFooter as? Element else {
            fatalError("View \(String(describing: headerFooter)) cannot be casted as \(headerFooterType.identifier)")
        }
        
        return element
    }
    
    public func hasAnyCells() -> Bool {
        numberOfSections > 0
    }
}
