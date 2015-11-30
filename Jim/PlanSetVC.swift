//
//  PlanSetVC
//  Jim
//
//  Created by Kyle McAlpine on 27/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class PlanSetVC: UIViewController {
    var exercise: Exercise?
    
    @IBOutlet private weak var exerciseNameLabel: UILabel!
    @IBOutlet private weak var repsTF: UITextField!
    @IBOutlet private weak var setsTF: UITextField!

    override func viewDidLoad() {
        self.exerciseNameLabel.text = self.exercise?.name
    }
    
    @IBAction func save() {
        let reps = Int(self.repsTF.text ?? "") ?? 0
        let sets = Int(self.setsTF.text ?? "") ?? 0
        
        var invalidFields = [UITextField]()
        if reps <= 0 {
            invalidFields.append(self.repsTF)
        }
        if sets <= 0 {
            invalidFields.append(self.setsTF)
        }
        
        if invalidFields.count > 0 {
            invalidFields.shake()
        } else if let exercise = self.exercise, user = PFUser.currentUser(), addWorkoutTVC = self.navigationController?.viewControllers.first as? AddWorkoutTVC {
            let set = SingleExerciseSet(exercise: exercise, reps: reps, sets: sets)
            set.ACL = PFACL(user: user)
            addWorkoutTVC.addExerciseSet(set, andPop: true)
        }
    }
}

class SetCell: UITableViewCell {
    private var _textLabel: UILabel?
    @IBOutlet override var textLabel: UILabel? {
        get { return self._textLabel }
        set { self._textLabel = newValue }
    }
    @IBOutlet var repsTF: UITextField!
    @IBOutlet var setsTF: UITextField!
}
