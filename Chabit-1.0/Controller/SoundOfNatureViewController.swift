//
//  SoundOfNatureViewController.swift
//  Chabit-1.0
//
//  Created by Fauzi Fauzi on 19/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit
import AVFoundation

class SoundOfNatureViewController: UIViewController {
    
    let nameSounds = ["Cast of Pods","","Anthem of Nature","Waterfall Rhapsody"]
    let soundDurations = ["4 min","3 min", "6 min"]
    let soundNames = ["cast_of_pods","cast_of_pods", "cast_of_pods"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let player : AVAudioPlayer?
        
        let url = Bundle.main.url(forResource: "name_file", withExtension: "mp3")!
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        }
        catch{
            print(error)
            
        }
        // Do any additional setup after loading the view.
    }
    
    
}
