//
//  OrderedSet.swift
//  Jim
//
//  Created by Kyle McAlpine on 15/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import Foundation

struct OrderedSet<T: Equatable> {
    private var elements = [T]()
    var count: Int { return self.elements.count }
    
    init() {}
    
    init(array: [T]) {
        if array.count > 0 {
            for i in 0...array.count - 1 {
                let element = array[i]
                var unique = true
                for j in 0...array.count - 1 {
                    if i != j && element == array[j] {
                        unique = false
                        break
                    }
                }
                if unique {
                    self.elements.append(element)
                }
            }
        }
    }
    
    subscript(index: Int) -> T {
        get {
            if index > self.elements.count || index < 0 {
                fatalError("Attempting to insert an object at an index that does not exist")
            }
            return self.elements[index]
        }
        
        set {
            var unique = true
            for element in self.elements {
                if element == newValue {
                    unique = false
                }
            }
            if unique {
                self.elements.insert(newValue, atIndex: index)
            }
        }
    }
    
    func toArray() -> [T] {
        return Array(self.elements)
    }
    
    func contains(element: T) -> Bool {
        for e in self.elements {
            if e == element {
                return true
            }
        }
        return false
    }
    
    mutating func append(element: T) {
        self[self.elements.count] = element
    }
    
    mutating func removeAtIndex(index: Int) {
        if index > self.elements.count || index < 0 {
            fatalError("Attempting to insert an object at an index that does not exist")
        }
        self.elements.removeAtIndex(index)
    }
    
    func indexOf(element: T) -> Int? {
        return self.elements.indexOf(element)
    }
}
