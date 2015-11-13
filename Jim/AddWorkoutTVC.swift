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
    lazy var workout: PFObject? = {
        guard let user = PFUser.currentUser() else {
            return nil
        }
        let wo = PFObject(className: "Workout")
        wo.ACL = PFACL(user: user)
        return wo
    }()
    
    @IBOutlet private weak var nameTF: UITextField!
    
    override func viewDidLoad() {
        self.nameTF.text = self.workout?["name"] as? String
    }
    
    @IBAction func save() {
        let workout = self.workout
        workout?["name"] = self.nameTF.text
        let _ = try? workout?.save()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            if let exercises = self.workout?["exercises"] as? [PFObject] {
                return exercises.count + 1
            } else {
                return 1
            }
        default:
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            if let exercises = self.workout?["exercises"] as? [PFObject], excerciseForRow = exercises[safe: indexPath.row] {
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
