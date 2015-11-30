//
//  Superset.swift
//  Jim
//
//  Created by Kyle McAlpine on 25/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class Superset: Set, PFSubclassing {
    @NSManaged var exercises: [SupersetExercise]
    
    static func parseClassName() -> String { return "Superset" }
    
    convenience init(exercises: [SupersetExercise], sets: Int) {
        self.init()
        self.exercises = exercises
        self.sets = sets
    }
}
