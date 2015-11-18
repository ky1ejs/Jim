//
//  Exercise.swift
//  Jim
//
//  Created by Kyle McAlpine on 15/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class Exercise: PFObject {
    @NSManaged var name: String
}

class StrengthExercise: Exercise, PFSubclassing {
    class func parseClassName() -> String {
        return "StrengthExercise"
    }
}

class CardioExercise: Exercise, PFSubclassing {
    class func parseClassName() -> String {
        return "CardioExercise"
    }
}

func ==(lhs: StrengthExercise, rhs: StrengthExercise) -> Bool {
    return lhs.objectId == rhs.objectId && rhs.name == lhs.name
}

func ==(lhs: CardioExercise, rhs: CardioExercise
    ) -> Bool {
    return lhs.objectId == rhs.objectId && rhs.name == lhs.name
}