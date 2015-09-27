//
//  ViewControllerforTableViewController.swift
//  Beacon
//
//  Created by Apple on 9/26/15.
//  Copyright © 2015 hackGT. All rights reserved.
//

import UIKit

class ViewControllerforTableViewController: UIViewController,UITextFieldDelegate {
    
    
    
    
    
    
    
    
    
    var something:String = ""
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n")
        {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.animatetextField(textField,up:true)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: textField, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = doneButton;
    }
    

    func animatetextField (textField:UITextField, up:Bool)
    {
        let movementDistance : CGFloat = -220.0; // tweak as needed
        let movementDuration = 0.3; // tweak as needed
        
        let movement = (up ? movementDistance : -movementDistance)
        
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        self.navigationItem.rightBarButtonItem = nil
        UIView.commitAnimations()
        
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("delegate got called")
        something = textField.text!
        let messageDictionary: [String: String!] = ["message": textField.text!]
        NSNotificationCenter.defaultCenter().postNotificationName("sendingMPCDataNotification", object: messageDictionary)
        self.insertNewObject(textField)
        self.animatetextField(textField, up: false)
        textField.clearsOnBeginEditing = true
        
    }
    
    
 
    weak var tableView:CommentsTableViewController?

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    if segue.identifier == "seguetoTable"
    {
        tableView  = segue.destinationViewController as? CommentsTableViewController
        
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //THIS IS THE EDIT BUTTON CHANGE IMPLEMENTATION from insert
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = editButton
        // Do any additional setup after loading the view.
        
    }
    
    
    func insertNewObject(sender : AnyObject?){
        
        print("table view is inserting an object \(something)")
        tableView?.insertNewObject(something)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
