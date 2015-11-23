//
//  SelectExercisesTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 07/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class SelectExercisesTVC: UITableViewController {
    var displayedExercises = OrderedSet<Exercise>()
    var selectedExercises = OrderedSet<Exercise>() {
        didSet {
            if self.segmentControl.selectedSegmentIndex == 0 {
                self.displayedExercises = selectedExercises
            }
        }
    }
    var exercises = OrderedSet<Exercise>() {
        didSet {
            if self.segmentControl.selectedSegmentIndex == 1 {
                self.displayedExercises = exercises
            }
        }
    }
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Exercise.query()?.findObjectsInBackgroundWithBlock({ (exercises, error) -> Void in
            if let exercises = exercises as? [Exercise] {
                self.exercises = OrderedSet(array: exercises)
            }
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let addWorkoutTVC = self.navigationController?.viewControllers.first as? AddWorkoutTVC {
            addWorkoutTVC.workout?.exercises = self.selectedExercises.toArray()
        }
    }
    
    @IBAction func segmentControlChanged(segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:     self.displayedExercises = self.selectedExercises
        case 1:     self.displayedExercises = self.exercises
        default:    break
        }
        self.tableView.reloadData()
    }
    
    
    // Table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedExercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        let exerciseForRow = self.displayedExercises[indexPath.row]
        cell.textLabel?.text = exerciseForRow.name
        cell.accessoryType = self.selectedExercises.contains(exerciseForRow) ? .Checkmark : .None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .None {
                self.selectedExercises.append(self.displayedExercises[indexPath.row])
                cell.accessoryType = .Checkmark
            } else if let excerciseIndex = self.selectedExercises.indexOf(self.displayedExercises[indexPath.row]) {
                self.selectedExercises.removeAtIndex(excerciseIndex)
                if self.segmentControl.selectedSegmentIndex == 0 {
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    self.displayedExercises = OrderedSet(array: self.selectedExercises.toArray())
                }
                cell.accessoryType = .None
            }
        }
    }
}
