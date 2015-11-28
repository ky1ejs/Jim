//
//  PlanSupersetTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 25/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

class PlanSupersetTVC: UITableViewController {
    var exercises = [Exercise]() {
        didSet {
                self.plannedExercises = [SupersetExercise]()
                exercises.forEach() { self.plannedExercises.append(SupersetExercise(exercise: $0, reps: 12))
            }
        }
    }
    private var plannedExercises = [SupersetExercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editing = true
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plannedExercises.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let exerciseForRow = self.plannedExercises[safe: indexPath.row] {
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.supersetExerciseCell)!
            cell.textLabel?.text = exerciseForRow.exercise.name
            cell.repsTF.text = "\(exerciseForRow.reps)"
            return cell
        } else {
            return tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.supersetTotalSetsCell)!
        }
    }
    
//    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        if let newSuperSet = self.exercises[safe: destinationIndexPath.section] as? PlannedSuperset {
//            if let supersetForSourceIndexPath = self.exercises[sourceIndexPath.section] as? PlannedSuperset {
//                
//            } else if let setForSourceIndexPath = self.exercises[sourceIndexPath.section] as? PlannedSet {
//                
//            }
//        } else if let existingDestinationSet = self.exercises[safe: destinationIndexPath.section] as? PlannedSet{
//            
//        }
//    }
}

class PlannedSetCell: UITableViewCell {
    private var _textLabel: UILabel?
    @IBOutlet override var textLabel: UILabel? {
        get { return self._textLabel }
        set { self._textLabel = newValue }
    }
    @IBOutlet var repsTF: UITextField!
    @IBOutlet var setsTF: UITextField!
}

class PlannedSupersetCell: UITableViewCell {
    private var _textLabel: UILabel?
    @IBOutlet override var textLabel: UILabel? {
        get { return self._textLabel }
        set { self._textLabel = newValue }
    }
    @IBOutlet var repsTF: UITextField!
}
