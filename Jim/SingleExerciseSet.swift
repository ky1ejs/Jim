//
//  SingleExerciseSet.swift
//  Jim
//
//  Created by Kyle McAlpine on 25/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class SingleExerciseSet: Set, PFSubclassing {
    @NSManaged var exercise: Exercise
    @NSManaged var reps: Int
    static func parseClassName() -> String { return "SingleExerciseSet" }
    
    convenience init(exercise: Exercise, reps: Int, sets: Int) {
        self.init()
        self.exercise = exercise
        self.reps = reps
        self.sets = sets
    }
}

