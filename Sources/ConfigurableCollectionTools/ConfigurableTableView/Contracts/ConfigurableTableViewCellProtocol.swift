//
//  ConfigurableTableViewCellProtocol.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import UIKit

public protocol ConfigurableTableViewCellProtocol where Self: UITableViewCell {
    
    func update(model: ConfigurableTableViewCellModelProtocol)
}
