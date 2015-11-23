//
//  AddExerciseTVC.swift
//  Jim
//
//  Created by Kyle McAlpine on 22/11/2015.
//  Copyright © 2015 Kyle McAlpine. All rights reserved.
//

import UIKit

class AddExerciseTVC: UITableViewController {
    @IBOutlet private weak var nameTF: UITextField!
    @IBOutlet private weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet private weak var urlTF: UITextField!
    
    
    @IBAction func save() {
        let name = self.nameTF.text ?? ""
        let url = NSURL(string: self.urlTF.text ?? "")
        
        var invalidFields = [UIView]()
        if name.characters.count == 0 {
            invalidFields.append(self.nameTF)
        }
        if url == nil && self.urlTF.text?.characters.count > 0 {
            invalidFields.append(self.urlTF)
        }
        guard let type = ExerciseType(rawValue: self.typeSegmentControl.selectedSegmentIndex) else {
            invalidFields.append(self.typeSegmentControl)
            invalidFields.shake()
            return
        }
        
        if invalidFields.count > 0 {
            invalidFields.shake()
        } else {
            Exercise(name: name, type: type, url: url).saveInBackgroundWithBlock({ (saved, error) -> Void in
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            })
        }
        
    }
    
    @IBAction func cancel() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
