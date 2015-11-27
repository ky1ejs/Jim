//
//  Workout.swift
//  Jim
//
//  Created by Kyle McAlpine on 15/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class Workout: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var plannedExercises: [PlannedExercise]
    
    class func parseClassName() -> String {
        return "Workout"
    }
}
