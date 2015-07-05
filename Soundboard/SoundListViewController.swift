//
//  SoundListViewController.swift
//  Soundboard
//
//  Created by VIJAY VENKATESH on 6/14/15.
//  Copyright (c) 2015 VIJAY VENKATESH. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


class SoundListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    
    var sounds: [Sound] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Roll Tide...
        self.tableView.dataSource = self
        self.tableView.delegate = self
          
              
    }
    
    override func viewWillAppear(animated: Bool) {
        // overriding the willAppear function - for the page to reappear
        super.viewWillAppear(animated)
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Sound")
        self.sounds = context.executeFetchRequest(request, error: nil)! as [Sound]
        
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sounds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var sound = self.sounds[indexPath.row]
        var cell = UITableViewCell()
        cell.textLabel!.text = sound.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var soundPath = NSBundle.mainBundle().pathForResource("vijaytest", ofType: "m4a")
        //var soundURL = NSURL.fileURLWithPath(soundPath!)
        
        var sound = self.sounds[indexPath.row]
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
       
        
        var pathComponents = [baseString, sound.url]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)!
        self.audioPlayer = AVAudioPlayer(contentsOfURL: audioNSURL, error: nil)
        //self.audioPlayer.rate = 4.0
        
        self.audioPlayer.play()
        
        // This guy deselects immediately 
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //This method says that the segue's destination view contoller is of type Newsoundviewcontroller and is in a var
        //then the nextViewcontroller's previous guy - is self
        
        var nextViewController = segue.destinationViewController as NewSoundViewController
        nextViewController.soundListViewController = self
    }
}

