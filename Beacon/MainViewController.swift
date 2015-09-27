//
//  MainViewController.swift
//  BeaconNextCopy
//
//  Created by Apple on 9/27/15.
//  Copyright © 2015 hackGT. All rights reserved.
//

import UIKit
import CoreLocation
import MultipeerConnectivity

class MainViewController: UIViewController, CLLocationManagerDelegate, MPCManagerDelegate {

    @IBOutlet weak var TechButton: UIButton!
    @IBOutlet weak var CloughButton: UIButton!

    var beaconRegion: CLBeaconRegion!
    
    var locationManager: CLLocationManager!

    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var isSearchingForBeacons = false
    
    var isAdvertising: Bool!
    
    var sentInvitation: Bool!
    
    var lastFoundBeacon: CLBeacon! = CLBeacon()
    
    var lastProximity: CLProximity! = CLProximity.Unknown
    
    var isConnectedToBeacon: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        if let uuid = NSUUID(UUIDString: "3CCFAFE3-F4F5-4CF7-B685-E8FF6EFE3567") {
            print("Beacon identifier set")
            beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "com.appcoda.beacondemo")
        } else {
            assertionFailure("UUID is in invalid format")
        }
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true

        isAdvertising = true
        
        sentInvitation = false

        isConnectedToBeacon = false
        
        TechButton.hidden = true
        CloughButton.hidden = true
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startUpdatingLocation()
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCSendData", name: "sendingMPCDataNotification", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: "receivedMPCDataNotification", object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        locationManager.requestStateForRegion(region)
    }
    
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion region: CLRegion) {
        if state == CLRegionState.Inside {
            locationManager.startRangingBeaconsInRegion(beaconRegion)
        } else {
            locationManager.stopRangingBeaconsInRegion(beaconRegion)
        }
    }

    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {        
        if beacons.count > 0 {
            let closestBeacon = beacons[0]
            
            if closestBeacon.minor != lastFoundBeacon.minor || closestBeacon.major != lastFoundBeacon.major {//|| lastProximity != closestBeacon.proximity {
                lastFoundBeacon = closestBeacon
                lastProximity = closestBeacon.proximity
                if closestBeacon.major.intValue == 1 {
                    TechButton.hidden = true
                    CloughButton.hidden = false
                }
                if closestBeacon.major.intValue == 2 {
                    TechButton.hidden = false
                    CloughButton.hidden = true
                }
                var proximityMessage: String!
                switch lastFoundBeacon.proximity {
                case CLProximity.Immediate:
                    proximityMessage = "Very close"
                case CLProximity.Near:
                    proximityMessage = "Close"
                case CLProximity.Far:
                    proximityMessage = "Far"
                case CLProximity.Unknown:
                    proximityMessage = "Beacon not found!"
                }
                if sentInvitation == false {
                    for (_, aPeer) in appDelegate.mpcManager.foundPeers.enumerate() {
                        print(aPeer.displayName)
                        if aPeer.displayName == "\(closestBeacon.major.intValue)_\(closestBeacon.minor.intValue)" {
                            appDelegate.mpcManager.browser.invitePeer(aPeer, toSession: appDelegate.mpcManager.session, withContext: nil, timeout: 20)
                            sentInvitation = true
                            break
                        }
                    }
                }
                                
                let text = "Beacon Details:\nMajor = " + String(closestBeacon.major.intValue) + "\nMinor = " + String(closestBeacon.minor.intValue) + "\nDistance:" + proximityMessage
                print(text)
            }
        }
        sentInvitation = false
    }

    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Beacon in Range")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("No beacons in range")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
        print(error)
    }

    func foundPeer()
    {
        print("Found Peer")
    }
    
    func lostPeer()
    {
        print("Lost peer")
    }

    func invitationWasReceived(fromPeer: String)
    {
        
    }
    
    func connectedWithPeer(peerID: MCPeerID)
    {
        print("Connected to peer \(peerID.displayName)")
    }

    func handleMPCSendData(notification: NSNotification) {
        let receivedDataDictionary = notification.object as! Dictionary<String, String>
        appDelegate.mpcManager.sendData(dictionaryWithData: receivedDataDictionary, toPeer: appDelegate.mpcManager.foundPeers[0])
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
