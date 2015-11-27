//
//  PlanSetsTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 25/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

class PlanSetsTVC: UITableViewController {
    var exercises = [Exercise]()
    private var plannedExercises = [PlannedExercise]()
    
    override func viewDidLoad() {
        self.exercises.forEach() { self.plannedExercises.append(PlannedSet(exercise: $0, reps: 12)) }
        self.editing = true
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.plannedExercises.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let superset = self.plannedExercises[section] as? PlannedSuperset {
            return superset.exercises.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let plannedExerciseForSection = self.plannedExercises[indexPath.section]
        if let plannedSet = plannedExerciseForSection as? PlannedSet {
            let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.plannedSetCell)!
            cell.textLabel?.text = plannedSet.exercise.name
            cell.repsTF.text = "\(plannedSet.reps)"
            cell.setsTF.text = "\(plannedSet.sets)"
            return cell
        } else if let plannedSuperset = plannedExerciseForSection as? PlannedSuperset {
            if let supersetExerciseForRow = plannedSuperset.exercises[safe: indexPath.row] {
                let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.plannedSupersetExerciseCell)!
                cell.textLabel?.text = supersetExerciseForRow.exercise.name
                cell.repsTF.text = "\(supersetExerciseForRow.reps)"
                return cell
            } else {
                return tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.supersetSetsCell)!
            }
        }
        return UITableViewCell()
    }
    
    
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if let newSuperSet = self.exercises[safe: destinationIndexPath.section] as? PlannedSuperset {
            if let supersetForSourceIndexPath = self.exercises[sourceIndexPath.section] as? PlannedSuperset {
                
            } else if let setForSourceIndexPath = self.exercises[sourceIndexPath.section] as? PlannedSet {
                
            }
        } else if let existingDestinationSet = self.exercises[safe: destinationIndexPath.section] as? PlannedSet{
            
        }
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
