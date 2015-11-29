//
//  PlanSupersetTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 25/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class PlanSupersetTVC: UITableViewController {
    var exercises: [Exercise] {
        get { return self.plannedExercises.exercises }
        set {
                self.plannedExercises = [SupersetExercise]()
                newValue.forEach() { self.plannedExercises.append(SupersetExercise(exercise: $0, reps: 12))
            }
        }
    }
    private var totalSets: Int = 3
    private var plannedExercises = [SupersetExercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editing = true
    }
    
    @IBAction func save() {
        if let user = PFUser.currentUser(), addWorkoutTVC = self.navigationController?.viewControllers.first as? AddWorkoutTVC {
            let plannedSuperset = PlannedSuperset(supersetExercises: self.plannedExercises, sets: self.totalSets)
            plannedSuperset.ACL = PFACL(user: user)
            addWorkoutTVC.addExercise(plannedSuperset, andPop: true)
        }
    }
    
    func repsTFTextChanged(textField: UITextField) {
        if let reps = Int(textField.text ?? "") {
            self.plannedExercises[textField.tag].reps = reps
        }
    }
    
    func totalSetsTFTextChanged(textField: UITextField) {
        if let sets = Int(textField.text ?? "") {
            self.totalSets = sets
        }
    }
    
    // MARK: Table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.plannedExercises.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let exerciseForRow = self.plannedExercises[safe: indexPath.row] {
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.supersetExerciseCell)!
            cell.textLabel?.text = exerciseForRow.exercise.name
            cell.repsTF.text = "\(exerciseForRow.reps)"
            cell.repsTF.tag = indexPath.row
            cell.repsTF.addTarget(self, action: "repsTFTextChanged:", forControlEvents: .EditingChanged)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.supersetTotalSetsCell)!
            cell.setsTF.text = "\(self.totalSets)"
            cell.setsTF.addTarget(self, action: "totalSetsTFTextChanged:", forControlEvents: .EditingChanged)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return indexPath.row != self.exercises.count
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let setToMove = self.plannedExercises[sourceIndexPath.row]
        self.plannedExercises.removeAtIndex(sourceIndexPath.row)
        self.plannedExercises.insert(setToMove, atIndex: destinationIndexPath.row)
    }
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

class TotalSetsCell: UITableViewCell {
    @IBOutlet var setsTF: UITextField!
}
