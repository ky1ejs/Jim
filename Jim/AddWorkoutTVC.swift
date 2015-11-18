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
    lazy var workout: Workout? = {
        guard let user = PFUser.currentUser() else {
            return nil
        }
        let wo = Workout()
        wo.ACL = PFACL(user: user)
        return wo
    }()
    
    @IBAction func save() {
        let _ = try? self.workout?.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let selectExercises = segue.destinationViewController as? SelectExercisesTVC, let selectedExercises = self.workout?.exercises {
            selectExercises.selectedExercises = OrderedSet(array: selectedExercises)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            if let exercises = self.workout?.exercises {
                return exercises.count + 1
            } else {
                return 1
            }
        default:
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            if let exercises = self.workout?.exercises, excerciseForRow = exercises[safe: indexPath.row] {
                let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
                cell.textLabel?.text = excerciseForRow.name
                return cell
            } else {
                return tableView.dequeueReusableCellWithIdentifier("AddExercisesCell")!
            }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("NameCell") as! TextFieldCell
            cell.textField.text = self.workout?.name
            return cell
        }
    }
}

class TextFieldCell: UITableViewCell {
    @IBOutlet private(set) weak var textField: UITextField!
}
