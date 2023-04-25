//
//  ConfigurableTableViewCellModelProtocol.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import UIKit

public protocol ConfigurableTableViewCellModelProtocol: AnyObject {
    
    var type: Int? { get set }
    
    var id: String? { get set }
    
    var entity: Any? { get set }
    
    func cellType() -> ConfigurableTableViewCellProtocol.Type
}
