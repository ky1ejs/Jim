//
//  WorkoutExercise.swift
//  Jim
//
//  Created by Kyle McAlpine on 23/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class WorkoutExercise: PFObject, PFSubclassing {
    @NSManaged var exercise: Exercise
    @NSManaged var reps: Int
    @NSManaged var sets: Int

    static func parseClassName() -> String { return "WorkoutExercise" }
    
    init(exercise: Exercise, reps: Int, sets: Int) {
        super.init()
        self.exercise = exercise
        self.reps = reps
        self.sets = sets
    }
}
