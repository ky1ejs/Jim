//
//  Extensions.swift
//  Jim
//
//  Created by Kyle McAlpine on 03/10/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

// MARK: -
extension UIView {
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 5, self.center.y))
        shake.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 5, self.center.y))
        self.layer.addAnimation(shake, forKey: "position")
    }
    
    func boing() {
        self.boing(delay: 0, completion: nil)
    }
    
    func boing(delay delay: NSTimeInterval?, completion: ((finished: Bool) -> Void)?) {
        let theDelay = delay != nil ? delay! : 0
        UIView.animateWithDuration(0.1, delay: theDelay, options: [], animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }) { (finished) -> Void in
                if finished {
                    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                        self.transform = CGAffineTransformMakeScale(1, 1)
                        }, completion: completion)
                }
        }
    }
}


// MARK: -
extension Array {
    subscript(safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}

extension Array where Element: UIView {
    func shake() {
        self.forEach() { $0.shake() }
    }
}

extension Array where Element: PlannedExercise {
    var exercises: [Exercise] {
        var e = [Exercise]()
        for workoutExercise in self {
            if let workoutExercise = workoutExercise as? PlannedSet {
                e.append(workoutExercise.exercise)
            } else if let workoutExercise = workoutExercise as? PlannedSuperset {
                for supersetExercise in workoutExercise.exercises {
                    e.append(supersetExercise.exercise)
                }
            }
        }
        return e
    }
}

extension Array where Element: SupersetExercise {
    var exercises: [Exercise] {
        var e = [Exercise]()
        for supersetExercise in self {
            e.append(supersetExercise.exercise)
        }
        return e
    }
}
