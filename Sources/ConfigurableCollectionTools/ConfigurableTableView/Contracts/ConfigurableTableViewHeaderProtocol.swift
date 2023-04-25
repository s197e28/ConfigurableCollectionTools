//
//  ConfigurableTableViewHeaderProtocol.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import UIKit

public protocol ConfigurableTableViewHeaderProtocol where Self: UITableViewHeaderFooterView {
    
    func update(model: ConfigurableTableViewHeaderModelProtocol)
}
