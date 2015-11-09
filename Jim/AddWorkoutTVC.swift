//
//  AddWorkoutTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 30/09/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class AddWorkoutTVC: UITableViewController {
    private var excercises = [PFObject]()
    
    @IBOutlet private weak var nameTF: UITextField!
    
    @IBAction func save() {
        guard let user = PFUser.currentUser() else {
            return
        }
        let workout = PFObject(className: "Workout")
        workout["name"] = self.nameTF.text
        workout.ACL = PFACL(user: user)
        let _ = try? workout.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:     return self.excercises.count + 1
        default:    return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            if let excerciseForRow = self.excercises[safe: indexPath.row] {
                let cell = tableView.dequeueReusableCellWithIdentifier("ExcerciseCell")!
                cell.textLabel?.text = excerciseForRow["name"] as? String
                return cell
            } else {
                return super.tableView(tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 1, inSection: 1))
            }
        default:
            return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        }
    }
}
