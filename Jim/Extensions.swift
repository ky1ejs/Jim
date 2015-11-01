//
//  Extensions.swift
//  Jim
//
//  Created by Kyle McAlpine on 03/10/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

extension Array {
    subscript(safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
