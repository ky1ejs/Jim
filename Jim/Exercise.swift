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
    @NSManaged private var urlString: String?
    var url: NSURL? {
        get { return NSURL(string: self.urlString ?? "") }
        set { self.urlString = newValue?.absoluteString }
    }
    @NSManaged private var typeCode: Int
    var type: ExerciseType {
        get { return ExerciseType(rawValue: self.typeCode)! }
        set { self.typeCode = newValue.rawValue }
    }
    
    class func parseClassName() -> String { return "Exercise" }
    
    convenience init(name: String, type: ExerciseType, url: NSURL?) {
        self.init()
        self.name = name
        self.type = type
        self.url = url
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? Exercise {
            return object.objectId == self.objectId && object.name == self.name
        }
        return false
    }
}
