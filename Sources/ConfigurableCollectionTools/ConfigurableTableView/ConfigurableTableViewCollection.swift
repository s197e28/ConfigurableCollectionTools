//
//  ConfigurableTableViewCollection.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import UIKit

public final class ConfigurableTableViewCollection {
    
    var indexes: [String: Int] = [:]
    
    public private(set) var sections: [ConfigurableTableViewSection] {
        didSet {
            recalculateIndexes()
        }
    }
    
    public var hasAnyItems: Bool {
        sections.firstIndex(where: { !$0.items.isEmpty }) != nil
    }
    
    public init(sections: [ConfigurableTableViewSection]) {
        self.sections = sections
        
        recalculateIndexes()
    }
    
    public convenience init(items: [ConfigurableTableViewCellModelProtocol]) {
        self.init(sections: [ConfigurableTableViewSection(items: items)])
    }
    
    public convenience init() {
        self.init(sections: [])
    }
    
    // MARK: Insert sections
    
    public func add(section: ConfigurableTableViewSection, at index: Int? = nil) {
        add(sections: [section], at: index)
    }
    
    public func add(sections: [ConfigurableTableViewSection], at index: Int? = nil) {
        let insertIndex = index ?? self.sections.count
        guard self.sections.count >= insertIndex else {
            fatalError("Section with index = \(insertIndex) not exist.")
        }
        
        self.sections.insert(contentsOf: sections, at: insertIndex)
    }
    
    // MARK: Insert items
    
    public func add(item: ConfigurableTableViewCellModelProtocol, at index: Int? = nil) {
        add(items: [item], at: index)
    }
    
    public func add(items: [ConfigurableTableViewCellModelProtocol], at index: Int? = nil) {
        let insertIndex = index ?? self.sections.count
        guard sections.count >= insertIndex else {
            fatalError("Section with index = \(insertIndex) not exist.")
        }
        
        if sections.count == insertIndex {
            sections.append(ConfigurableTableViewSection(items: items))
            return
        }
        
        sections[insertIndex].add(items: items)
    }
    
    public func addToLastSection(item: ConfigurableTableViewCellModelProtocol) {
        addToLastSection(items: [item])
    }
    
    public func addToLastSection(items: [ConfigurableTableViewCellModelProtocol]) {
        guard let section = sections.last else {
            add(items: items)
            return
        }
        
        section.add(items: items)
    }
    
    // MARK: Update
    
    public func update(with items: [ConfigurableTableViewCellModelProtocol]) {
        sections.removeAll()
        add(items: items)
    }
    
    public func update(with sections: [ConfigurableTableViewSection]) {
        self.sections.removeAll()
        add(sections: sections)
    }
    
    // MARK: Remove
    
    public func remove(sectionAt index: Int) {
        guard sections.count > index else {
            return
        }
        
        sections.remove(at: index)
    }
    
    public func remove(sectionWithId id: String) {
        guard let sectionIndex = sections.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        sections.remove(at: sectionIndex)
    }
    
    public func remove(cellAt index: IndexPath) {
        guard let section = sections[safe: index.section], section.items.count > index.item else {
            return
        }
        
        section.remove(at: index.item)
    }
    
    public func removeAll() {
        sections.removeAll()
    }
    
    // MARK: Other
    
    @discardableResult
    public func replace(section: ConfigurableTableViewSection, at index: Int) -> Bool {
        guard sections.count > index else {
            return false
        }
        
        sections[index] = section
        return true
    }
    
    // MARK: Private methods
    
    private func recalculateIndexes() {
        let sectionIds = sections.map({ $0.id }).enumerated()
        
        indexes = sectionIds.reduce(into: [String: Int](), { $0[$1.element ?? ""] = $1.offset })
    }
}

// MARK: ConfigurableTableViewCollectionProtocol

extension ConfigurableTableViewCollection: ConfigurableTableViewCollectionProtocol {
    
    public func numberOfSections() -> Int {
        sections.count
    }
    
    public func numberOfItems(in section: Int) -> Int {
        sections[safe: section]?.items.count ?? 0
    }
    
    public func cellType(at indexPath: IndexPath) -> ConfigurableTableViewCellProtocol.Type? {
        sections[safe: indexPath.section]?.items[safe: indexPath.row]?.cellType()
    }
    
    public func cellId<CellId: RawRepresentable>(at indexPath: IndexPath) -> CellId? where CellId.RawValue == Int {
        guard let value = sections[safe: indexPath.section]?.items[safe: indexPath.row]?.type else {
            return nil
        }
        
        return CellId(rawValue: value)
    }
    
    public func sectionId<SectionId: RawRepresentable>(at section: Int) -> SectionId? where SectionId.RawValue == Int {
        guard let value = sections[safe: section]?.type else {
            return nil
        }
        
        return SectionId(rawValue: value)
    }
    
    public func cell(at indexPath: IndexPath) -> ConfigurableTableViewCellModelProtocol? {
        guard let sectionModel = sections[safe: indexPath.section],
              let cellModel = sectionModel.items[safe: indexPath.row] else {
            return nil
        }
        
        return cellModel
    }
    
    public func hasHeader(at section: Int) -> Bool {
        sections[safe: section]?.header != nil
    }
    
    public func hasFooter(at section: Int) -> Bool {
        sections[safe: section]?.footer != nil
    }
    
    public func headerType(at section: Int) -> ConfigurableTableViewHeaderProtocol.Type? {
        sections[safe: section]?.header?.getType()
    }
    
    public func footerType(at section: Int) -> ConfigurableTableViewHeaderProtocol.Type? {
        sections[safe: section]?.footer?.getType()
    }
    
    public func header(at section: Int) -> ConfigurableTableViewHeaderModelProtocol? {
        guard let sectionModel = sections[safe: section] else {
            return nil
        }
        
        return sectionModel.header
    }
    
    public func footer(at section: Int) -> ConfigurableTableViewHeaderModelProtocol? {
        guard let sectionModel = sections[safe: section] else {
            return nil
        }
        
        return sectionModel.footer
    }
    
    public func identifier<SectionId>(forSection sectionIndex: Int) -> SectionId? where SectionId: RawRepresentable, SectionId.RawValue == Int {
        guard let identifierValue = sections[safe: sectionIndex]?.type else {
            return nil
        }
        
        return SectionId(rawValue: identifierValue)
    }
    
    public func identifier<CellId>(for indexPath: IndexPath) -> CellId? where CellId: RawRepresentable, CellId.RawValue == Int {
        guard let identifierValue = sections[safe: indexPath.section]?.items[safe: indexPath.row]?.type else {
            return nil
        }
        
        return CellId(rawValue: identifierValue)
    }
}
