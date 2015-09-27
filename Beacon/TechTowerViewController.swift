//
//  TechTowerViewController.swift
//  BeaconNextCopy
//
//  Created by Apple on 9/27/15.
//  Copyright © 2015 hackGT. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TechTowerViewController: UIViewController {

    
    @IBOutlet weak var Image_TechTower: UIImageView!
    
    
    weak var playerViewController1 : AVPlayerViewController?
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "shashank_tahoe"
        {
            playerViewController1 = segue.destinationViewController as? AVPlayerViewController
            
            
            
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

     
        
        
        if let url = NSBundle.mainBundle().URLForResource("what1", withExtension: "mp4")
        {
            let movie = AVAsset(URL: url)
            let item = AVPlayerItem(asset: movie)
            print("reached url creation")
            playerViewController1?.player = AVPlayer(playerItem: item)
            
        }
        
        Image_TechTower.image = UIImage(named: "TT_art.jpg");
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
      
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
