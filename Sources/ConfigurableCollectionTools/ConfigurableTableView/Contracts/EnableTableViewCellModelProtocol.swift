//
//  EnableTableViewCellModelProtocol.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 1/22/23.
//

import Foundation

public protocol EnableTableViewCellModelProtocol: AnyObject {
    
    var isEnabled: Bool { get set }
}

public protocol EnableTableViewCellProtocol: AnyObject {
    
    func set(isEnabled: Bool)
}
