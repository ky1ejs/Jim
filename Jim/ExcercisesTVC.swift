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
    private var displayedExercises = [PFObject]()
    private var strengthExercises = [PFObject]() {
        didSet {
            if self.segmentControl.selectedSegmentIndex == 1 {
                self.displayedExercises = strengthExercises
                self.tableView.reloadData()
            }
        }
    }
    private var cardioExercises = [PFObject]() {
        didSet {
            if self.segmentControl.selectedSegmentIndex == 0 {
                self.displayedExercises = cardioExercises
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        PFQuery(className: "CardioExercise").findObjectsInBackgroundWithBlock { (workouts, error) in
            if let workouts = workouts {
                self.cardioExercises = workouts
            }
        }
        PFQuery(className: "StrengthExercise").findObjectsInBackgroundWithBlock { (workouts, error) in
            if let workouts = workouts {
                self.strengthExercises = workouts
            }
        }
    }
    
    
    // MARK: - Segment control
    @IBAction func segmentControlSelectedChanged(segmentControl: UISegmentedControl) {
        self.displayedExercises = segmentControl.selectedSegmentIndex == 0 ? self.cardioExercises : self.strengthExercises
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedExercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        cell.textLabel?.text = self.displayedExercises[indexPath.row]["name"] as? String
        return cell
    }
}
