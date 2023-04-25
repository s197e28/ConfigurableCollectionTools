//
//  ConfigurableTableViewCollectionProtocol.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import Foundation

public protocol ConfigurableTableViewCollectionProtocol: AnyObject {
    
    func numberOfSections() -> Int
    
    func numberOfItems(in section: Int) -> Int
    
    func cellType(at indexPath: IndexPath) -> ConfigurableTableViewCellProtocol.Type?
    
    func cell(at indexPath: IndexPath) -> ConfigurableTableViewCellModelProtocol?
    
    func hasHeader(at section: Int) -> Bool
    
    func hasFooter(at section: Int) -> Bool
    
    func headerType(at section: Int) -> ConfigurableTableViewHeaderProtocol.Type?
    
    func footerType(at section: Int) -> ConfigurableTableViewHeaderProtocol.Type?
    
    func header(at section: Int) -> ConfigurableTableViewHeaderModelProtocol?
    
    func footer(at section: Int) -> ConfigurableTableViewHeaderModelProtocol?
}
