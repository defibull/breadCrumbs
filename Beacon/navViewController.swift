//
//  navViewController.swift
//  BeaconNextCopy
//
//  Created by Apple on 9/26/15.
//  Copyright © 2015 hackGT. All rights reserved.
//

import UIKit

class navViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if ((self.navigationController?.navigationItem) != nil)
        {
            print("title being set")
          self.navigationController?.navigationItem.title = "GEORGIA TECH"
        }
    

        // Do any additional setup after loading the view.
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
