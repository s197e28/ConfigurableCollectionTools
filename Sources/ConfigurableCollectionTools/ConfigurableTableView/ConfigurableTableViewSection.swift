//
//  ConfigurableTableViewSection.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import UIKit

public final class ConfigurableTableViewSection {
    
    private var indexes: [String: Int] = [:]
    
    public private(set) var type: Int?
    public private(set) var id: String?
    public private(set) var entity: Any?
    public var header: ConfigurableTableViewHeaderModelProtocol?
    public var footer: ConfigurableTableViewHeaderModelProtocol?
    public private(set) var items: [ConfigurableTableViewCellModelProtocol] {
        didSet {
            recalculateIndexes()
        }
    }
    
    public init(type: Int? = nil,
                id: String? = nil,
                entity: Any? = nil,
                header: ConfigurableTableViewHeaderModelProtocol? = nil,
                footer: ConfigurableTableViewHeaderModelProtocol? = nil,
                items: [ConfigurableTableViewCellModelProtocol] = []) {
        self.type = type
        self.id = id
        self.entity = entity
        self.header = header
        self.footer = footer
        self.items = items
        
        recalculateIndexes()
    }
    
    public func add(items: [ConfigurableTableViewCellModelProtocol], at index: Int? = nil) {
        let insertIndex = index ?? self.items.count
        guard self.items.count >= insertIndex else {
            fatalError("Item with index = \(insertIndex) not exist.")
        }
        
        self.items.insert(contentsOf: items, at: insertIndex)
    }
    
    public func update(with items: [ConfigurableTableViewCellModelProtocol]) {
        self.items.removeAll()
        add(items: items)
    }
    
    // MARK: Indexes
    
    public func itemIndex(withId id: String) -> Int? {
        indexes[id]
    }
    
    public func index<CellId: RawRepresentable>(cellWithType cellType: CellId) -> Int? where CellId.RawValue == Int {
        items.firstIndex(where: { $0.type == cellType.rawValue })
    }
    
    // MARK: Other
    
    @discardableResult
    public func remove(at index: Int) -> Int? {
        items.remove(at: index)
        return index
    }
    
    public func replace(item: ConfigurableTableViewCellModelProtocol, at index: Int) {
        items[index] = item
    }
    
    // MARK: Private methods
    
    private func recalculateIndexes() {
        indexes = items.map({ $0.id }).enumerated().reduce(into: [String: Int](), { $0[$1.element ?? ""] = $1.offset })
    }
}
