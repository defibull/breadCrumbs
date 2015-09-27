//
//  ViewController.swift
//  Beacon
//
//  Created by Apple on 9/26/15.
//  Copyright © 2015 hackGT. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var Move_button: UIButton!
    
    @IBOutlet weak var Image: UIImageView!

    
    
    
    weak var playerViewController : AVPlayerViewController?
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "video_play"
        {
            playerViewController = segue.destinationViewController as? AVPlayerViewController
            
            
            
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    if let url = NSBundle.mainBundle().URLForResource("what", withExtension: "mp4")
    {
        let movie = AVAsset(URL: url)
        let item = AVPlayerItem(asset: movie)
        print("reached url creation")
        playerViewController?.player = AVPlayer(playerItem: item)
        
        }
        
        Image.image = UIImage(named: "Location Title-01.jpg");
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

}

