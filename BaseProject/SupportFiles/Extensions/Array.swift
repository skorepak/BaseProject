//
//  Array.swift
//  BaseProject
//
//  Created by Skorepa on 12.07.2017.
//  Copyright © 2017 Skorepak. All rights reserved.
//

import Foundation

// Credit: http://stackoverflow.com/questions/24938948/array-extension-to-remove-object-by-value
extension Array where Element: Equatable {
    /**
     Remove first collection element that is equal to the given `object`
     - Parameter object: Object to remove
     */
    mutating func remove(_ object: Element) -> Element? {
        if let index = index(of: object) {
            return remove(at: index)
        }
        return nil
    }
}
