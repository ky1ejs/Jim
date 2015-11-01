//
//  ExcercisesTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 01/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class ExcercisesTVCTableViewController: UITableViewController {
    private var workouts = [PFObject]()
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "Excercise")
        query.findObjectsInBackgroundWithBlock { (workouts, error) -> Void in
            guard let workouts = workouts else {
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
        cell.textLabel?.text = self.workouts[indexPath.row]["name"] as? String
        return cell
    }
    
    @IBAction func unwindToWorkoutTVC(segue: UIStoryboardSegue) {}

}
