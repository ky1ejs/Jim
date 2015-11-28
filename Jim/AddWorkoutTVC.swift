//
//  AddWorkoutTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 30/09/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class AddWorkoutTVC: UITableViewController, UIActionSheetDelegate {
    lazy var workout: Workout? = {
        guard let user = PFUser.currentUser() else {
            return nil
        }
        let wo = Workout()
        wo.ACL = PFACL(user: user)
        return wo
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @IBAction func save() {
        let _ = try? self.workout?.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nameTextFieldValueChanged(sender: UITextField) {
        if let text = sender.text {
            self.workout?.name = text
        }
    }
    
    func addExercise(exercise: PlannedExercise, andPop pop: Bool) {
        self.workout?.plannedExercises.append(exercise)
        if pop {
            self.navigationController?.popToViewController(self, animated: true)
        }
    }
    
    
    // MARK: - Table view
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            if let plannedExercises = self.workout?.plannedExercises {
                return plannedExercises.exercises.count + 1
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
            if let plannedExercises = self.workout?.plannedExercises, plannedExercisesForRow = plannedExercises.exercises[safe: indexPath.row] {
                let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
                cell.textLabel?.text = plannedExercisesForRow.name
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier == R.reuseIdentifier.addExercisesCell.identifier {
            let actionSheet = UIAlertController(title: "Add exercise", message: nil, preferredStyle: .ActionSheet)
            actionSheet.addAction(UIAlertAction(title: "Single exercise", style: .Default, handler: { alertAction in
                self.performSegueWithIdentifier(R.segue.addSet, sender: self)
            }))
            actionSheet.addAction(UIAlertAction(title: "Superset", style: .Default, handler: { alertAction in
                self.performSegueWithIdentifier(R.segue.addSuperset, sender: self)
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            self.presentViewController(actionSheet, animated: true, completion: nil)
        }
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

class TextFieldCell: UITableViewCell {
    @IBOutlet private(set) weak var textField: UITextField!
}
