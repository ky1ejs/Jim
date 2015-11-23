//
//  AddExerciseTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 22/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

class AddExerciseTVC: UITableViewController {
    
    
    @IBAction func cancel() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
