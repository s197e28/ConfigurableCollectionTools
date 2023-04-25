//
//  Collection+Extensions.swift
//  ConfigurableCollectionTools
//
//  Created by Nikita Morozov on 6/14/22.
//

import Foundation

public extension Collection {
    
    subscript (safe index: Index) -> Element? {
        
        indices.contains(index) ? self[index] : nil
    }
}
