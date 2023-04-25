//
//  ConfigurableTableViewCollection+ViewUpdate.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 1/28/23.
//

import Foundation
import UIKit

extension ConfigurableTableViewCollection {
    
    public func insert(_ tableView: UITableView, animation: UITableView.RowAnimation = .fade, block: (() -> Void)) {
        let beforeCells = Set(castOfCells())
        block()
        let afterCells = Set(castOfCells())
        
        let differenceCells = Array(beforeCells.symmetricDifference(afterCells)).sorted(by: <)
        
        var cellIndexesToInsert: [IndexPath] = []
        var sectionIndexesToInsert: [Int] = []
        
        for cellIndex in differenceCells {
            if beforeCells.contains(where: { $0.section == cellIndex.section }) {
                cellIndexesToInsert.append(cellIndex)
            } else if !sectionIndexesToInsert.contains(where: { $0 == cellIndex.section }) {
                sectionIndexesToInsert.append(cellIndex.section)
            }
        }
        
        if cellIndexesToInsert.isEmpty == false {
            tableView.insertRows(at: cellIndexesToInsert, with: animation)
        }
        if sectionIndexesToInsert.isEmpty == false {
            tableView.insertSections(IndexSet(sectionIndexesToInsert), with: animation)
        }
    }
    
    private func castOfCells() -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        
        for (i, section) in sections.enumerated() {
            guard section.items.count > 0 else {
                continue
            }
            
            let sectionIndexPaths = (0...section.items.count - 1).map {
                IndexPath(item: $0, section: i)
            }
            
            indexPaths.append(contentsOf: sectionIndexPaths)
        }
        
        return indexPaths
    }
}
