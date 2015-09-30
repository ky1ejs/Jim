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
}
