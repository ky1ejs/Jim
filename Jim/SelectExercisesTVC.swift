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
    var displayedExercises = [PFObject]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var selectedExercises = [PFObject]() {
        didSet {
            if self.segmentControl.selectedSegmentIndex == 0 {
                self.displayedExercises = selectedExercises
            }
        }
    }
    var cardioExercises = [PFObject]() {
        didSet {
            if self.segmentControl.selectedSegmentIndex == 1 {
                self.displayedExercises = cardioExercises
            }
        }
    }
    var strengthExercises = [PFObject]() {
        didSet {
            if self.segmentControl.selectedSegmentIndex == 2 {
                self.displayedExercises = strengthExercises
            }
        }
    }
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFQuery(className: "CardioExercise").findObjectsInBackgroundWithBlock { (workouts, error) in
            if let workouts = workouts {
                self.cardioExercises = workouts
            }
        }
        PFQuery(className: "StrengthExercise").findObjectsInBackgroundWithBlock { (workouts, error) in
            if let workouts = workouts {
                self.strengthExercises = workouts
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let addWorkoutTVC = self.navigationController?.viewControllers.first as? AddWorkoutTVC {
            addWorkoutTVC.workout?["exercises"] = self.selectedExercises
        }
    }
    
    @IBAction func segmentControlChanged(segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:     self.displayedExercises = self.selectedExercises
        case 1:     self.displayedExercises = self.cardioExercises
        case 2:     self.displayedExercises = self.strengthExercises
        default:    break
        }
    }
    
    
    // Table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedExercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        let exerciseForRow = self.displayedExercises[indexPath.row]
        cell.textLabel?.text = exerciseForRow["name"] as? String
        cell.accessoryType = self.selectedExercises.contains(exerciseForRow) ? .Checkmark : .None
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            self.tableView.beginUpdates()
            if cell.accessoryType == .None {
                self.selectedExercises.append(self.displayedExercises[indexPath.row])
                cell.accessoryType = .Checkmark
            } else if let excerciseIndex = self.selectedExercises.indexOf(self.displayedExercises[indexPath.row]) {
                self.selectedExercises.removeAtIndex(excerciseIndex)
                cell.accessoryType = .None
            }
            self.tableView.endUpdates()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
