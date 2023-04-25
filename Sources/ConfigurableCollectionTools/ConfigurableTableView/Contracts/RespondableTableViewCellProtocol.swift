//
//  RespondableTableViewCellProtocol.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 1/28/23.
//

import Foundation

public struct RespondableConfig {
    
    public var isPreviousInputEnabled: Bool?
    
    public var isNextInputEnabled: Bool?
    
    public init(isPreviousInputEnabled: Bool? = nil, isNextInputEnabled: Bool? = nil) {
        self.isPreviousInputEnabled = isPreviousInputEnabled
        self.isNextInputEnabled = isNextInputEnabled
    }
}

public protocol RespondableTableViewCellModelProtocol: AnyObject {
    
    var respondableConfig: RespondableConfig? { get set }
}

public protocol RespondableTableViewCellProtocol: AnyObject {
    
    func update(respondableConfig: RespondableConfig?)
}

extension RespondableTableViewCellProtocol {
    
    public func update(respondableConfig: RespondableConfig?) { }
}
