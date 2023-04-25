//
//  ConfigurableTableViewCollection+Respondable.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 1/28/23.
//

import Foundation
import UIKit

extension ConfigurableTableViewCollection {
    
    public func configureRespondableCells(in tableView: UITableView) {
        var currentCellIndexPath: IndexPath?
        var currentIndex = 0
        
        for (sectionIndex, section) in sections.enumerated() {
            for (itemIndex, item) in section.items.enumerated() {
                guard item is RespondableTableViewCellModelProtocol else {
                    continue
                }
                
                if let currentCellIndexPath = currentCellIndexPath {
                    updateCell(
                        indexPath: currentCellIndexPath,
                        isPreviousInputEnabled: currentIndex > 0,
                        isNextInputEnabled: true,
                        tableView
                    )
                    currentIndex += 1
                }
                
                currentCellIndexPath = IndexPath(item: itemIndex, section: sectionIndex)
            }
        }
        
        if let currentCellIndexPath = currentCellIndexPath {
            updateCell(indexPath: currentCellIndexPath, isPreviousInputEnabled: currentIndex > 0, isNextInputEnabled: false, tableView)
        }
    }
    
    private func updateCell(indexPath: IndexPath, isPreviousInputEnabled: Bool, isNextInputEnabled: Bool, _ tableView: UITableView) {
        guard let cellModel = cell(at: indexPath) as? RespondableTableViewCellModelProtocol else {
            return
        }
        
        let config = RespondableConfig(
            isPreviousInputEnabled: isPreviousInputEnabled,
            isNextInputEnabled: isNextInputEnabled
        )
        cellModel.respondableConfig = config
        
        if let cell = tableView.cellForRow(at: indexPath) as? RespondableTableViewCellProtocol {
            cell.update(respondableConfig: config)
        }
    }
}

extension UITableView {
    
    @discardableResult
    public func activateFirstCellResponder() -> Bool {
        let indexPath = IndexPath(item: 0, section: 0)
        if let cell = cellForRow(at: indexPath), cell.canBecomeFirstResponder {
            cell.becomeFirstResponder()
            return true
        }
        
        return activateNextResponder(indexPath)
    }
    
    @discardableResult
    public func nextCellResponder(for cell: UITableViewCell) -> Bool {
        guard let indexPath = indexPath(for: cell) else {
            return false
        }
        
        return activateNextResponder(indexPath)
    }
    
    @discardableResult
    public func previousCellResponder(for cell: UITableViewCell) -> Bool {
        guard let indexPath = indexPath(for: cell) else {
            return false
        }
        
        var currentCellIndex = indexPath
        while true {
            guard let cellIndex = previousCellIndex(from: currentCellIndex) else {
                break
            }
            
            currentCellIndex = cellIndex
            
            guard let cell = cellForRow(at: currentCellIndex), cell.canBecomeFirstResponder else {
                continue
            }
            
            cell.becomeFirstResponder()
            return true
        }
        
        return false
    }
    
    private func activateNextResponder(_ indexPath: IndexPath) -> Bool {
        var currentCellIndex = indexPath
        while true {
            guard let cellIndex = nextCellIndex(from: currentCellIndex) else {
                break
            }
            
            currentCellIndex = cellIndex
            
            guard let cell = cellForRow(at: currentCellIndex), cell.canBecomeFirstResponder else {
                continue
            }
            
            cell.becomeFirstResponder()
            return true
        }
        
        return false
    }
    
    private func nextCellIndex(from indexPath: IndexPath) -> IndexPath? {
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        
        let numberOfItemsInSection = numberOfRows(inSection: sectionIndex)
        
        if itemIndex + 1 < numberOfItemsInSection {
            return IndexPath(item: itemIndex + 1, section: sectionIndex)
        }
        
        guard sectionIndex + 1 < numberOfSections else {
            return nil
        }
        
        for i in (sectionIndex + 1...numberOfSections - 1) {
            guard numberOfRows(inSection: sectionIndex) > 0 else {
                continue
            }
            
            return IndexPath(item: 0, section: i)
        }
        
        return nil
    }
    
    private func previousCellIndex(from indexPath: IndexPath) -> IndexPath? {
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        
        if itemIndex > 0 {
            return IndexPath(item: itemIndex - 1, section: sectionIndex)
        }
        
        guard sectionIndex > 0 else {
            return nil
        }
        
        for i in (0...sectionIndex - 1).reversed() {
            let numberOfItems = numberOfRows(inSection: i)
            guard numberOfItems > 0 else {
                continue
            }
            
            return IndexPath(item: numberOfItems - 1, section: i)
        }
        
        return nil
    }
}
