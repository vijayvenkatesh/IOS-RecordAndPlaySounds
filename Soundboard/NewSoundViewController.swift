//
//  NewSoundViewController.swift
//  Soundboard
//
//  Created by VIJAY VENKATESH on 6/14/15.
//  Copyright (c) 2015 VIJAY VENKATESH. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData



class NewSoundViewController : UIViewController {

    required init(coder aDecoder: NSCoder) {
        var baseString : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        
        self.audioURL = NSUUID().UUIDString + ".m4a"

        var pathComponents = [baseString, self.audioURL]
        var audioNSURL = NSURL.fileURLWithPathComponents(pathComponents)!
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        var recordSettings: [NSObject : AnyObject] = Dictionary()
        recordSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        recordSettings[AVSampleRateKey] = 44100.0
        recordSettings[AVNumberOfChannelsKey] = 2
        
        self.audioRecorder = AVAudioRecorder(URL: audioNSURL, settings: recordSettings, error: nil)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord()
        
        //code that runs the first time this class runs , even before viewDidLoad
        // Super init is below
        super.init(coder: aDecoder)
    }
    
    
    @IBOutlet weak var soundTextField: UITextField!
    
    @IBOutlet weak var recordButton: UIButton!
    
    var soundListViewController = SoundListViewController()
    
    var audioRecorder : AVAudioRecorder
    var audioURL : String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Roll Tide..
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        // Want dismiss to be animated - TRUE
        // What to do upon completion - nothing
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        // Create a sound object
        //var sound = Sound()
        // Save sound to core data
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        var sound = NSEntityDescription.insertNewObjectForEntityForName("Sound", inManagedObjectContext: context
            ) as Sound
        sound.name = self.soundTextField.text
        sound.url = self.audioURL
        //Save to coredata
        context.save(nil)
        
        //sound.URL = self.audioURL
        
        // Add the sound to soundsArray
        //self.soundListViewController.sounds.append(sound)
        
        // Dismiss Viewcontroller
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func recordTapped(sender: AnyObject) {
        if self.audioRecorder.recording {
            //if recording
            self.audioRecorder.stop()
            self.recordButton.setTitle("RECORD", forState: UIControlState.Normal)
            
        } else {
            // if not recording
            var session = AVAudioSession.sharedInstance()
            session.setActive(true, error: nil)
            self.audioRecorder.record()
            self.recordButton.setTitle("Finish recording", forState: UIControlState.Normal)
        }
        
        //Buttons can be normal or disabled or other states - this time we want normal
    }
    
    
}
