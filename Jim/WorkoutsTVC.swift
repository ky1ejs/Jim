//
//  WorkoutsTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 30/09/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class WorkoutsTVC: UITableViewController {
    private var workouts = [Workout]()
    
    override func viewWillAppear(animated: Bool) {
        let query = Workout.query()
        query?.includeKey("plannedExercises.exercise")
        query?.includeKey("plannedExercises.exercises")
        query?.findObjectsInBackgroundWithBlock { (workouts, error) -> Void in
            guard let workouts = workouts as? [Workout] else {
                return
            }
            self.workouts = workouts
            self.tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workouts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        cell.textLabel?.text = self.workouts[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let workoutToDelete = self.workouts[indexPath.row]
        self.workouts.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        workoutToDelete.deleteInBackgroundWithBlock { (deleted, error) -> Void in
            if !deleted {
                self.workouts.insert(workoutToDelete, atIndex: indexPath.row)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailVC = segue.destinationViewController as? WorkoutDetailTVC, selectedIndex = self.tableView.indexPathForSelectedRow {
            detailVC.workout = self.workouts[selectedIndex.row]
        }
    }
}

