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
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Exercise {
            return object.objectId == self.objectId && object.name == self.name
        }
        return false
    }
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
