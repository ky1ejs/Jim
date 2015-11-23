//
//  ExcercisesTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 01/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit
import Parse

class ExcercisesTVC: UITableViewController {
    private var exercises = [Exercise]()
    
    override func viewDidLoad() {
        Exercise.query()?.findObjectsInBackgroundWithBlock({ (exercises, error) -> Void in
            if let exercises = exercises as? [Exercise] {
                self.exercises = exercises
                self.tableView.reloadData()
            }
        })
    }
    
    
    // MARK: - Table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        cell.textLabel?.text = self.exercises[indexPath.row].name
        return cell
    }
}
