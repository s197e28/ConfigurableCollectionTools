//
//  ConfigurableTableViewSectionHeaderModelProtocol.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import UIKit

public protocol ConfigurableTableViewHeaderModelProtocol: AnyObject {
    
    func getType() -> ConfigurableTableViewHeaderProtocol.Type
}
