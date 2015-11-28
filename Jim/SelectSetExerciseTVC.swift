//
//  SelectSetExerciseTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 27/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

class SelectSetExerciseTVC: UITableViewController {
    private var exercises = [Exercise]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Exercise.query()?.findObjectsInBackgroundWithBlock({ (exercises, error) -> Void in
            if let exercises = exercises as? [Exercise] {
                self.exercises = exercises
                self.tableView.reloadData()
            }
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.selectSetExerciseBasicCell)!
        cell.textLabel?.text = self.exercises[indexPath.row].name
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let planSetVC = segue.destinationViewController as? PlanSetVC, selectedIndex = self.tableView.indexPathForSelectedRow {
            planSetVC.exercise = self.exercises[selectedIndex.row]
        }
    }
}
