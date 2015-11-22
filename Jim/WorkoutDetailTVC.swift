//
//  WorkoutDetailTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 18/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

class WorkoutDetailTVC: UITableViewController {
    var workout: Workout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.workout?.fetchIfNeededInBackgroundWithBlock({ (object, error) -> Void in
        
//        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:     return 1
        case 1:     return self.workout?.exercises.count ?? 0
        default:    return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        switch indexPath.section {
        case 0:     cell.textLabel?.text = self.workout?.name
        case 1:     cell.textLabel?.text = self.workout?.exercises[indexPath.row].name
        default:    break
        }
        return cell
    }
}
