//
//  Exercise.swift
//  Jim
//
//  Created by Kyle McAlpine on 15/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

enum ExerciseType: Int {
    case Strength
    case Cardio
}

class Exercise: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var reps: Int
    @NSManaged var sets: Int
    
    @NSManaged private var typeCode: Int
    var type: ExerciseType {
        get { return ExerciseType(rawValue: self.typeCode)! }
        set { self.typeCode = newValue.rawValue }
    }
    
    class func parseClassName() -> String { return "Exercise" }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Exercise {
            return object.objectId == self.objectId && object.name == self.name
        }
        return false
    }
}
