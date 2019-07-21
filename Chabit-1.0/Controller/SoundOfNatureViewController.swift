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
    
    var player : AVAudioPlayer?
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var soundsCollectionView: UICollectionView!
    
    var nameSounds = ["Cast of Pods","Anthem of Nature","Waterfall Rhapsody"]
    var soundDurations = ["4 min","3 min", "6 min"]
    var soundNames = ["pods","rain", "pods"]
    var isPlayed: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.alpha = 0
        
        soundsCollectionView.delegate = self
        soundsCollectionView.dataSource = self
        
    }
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        player?.stop()
        stopButton.alpha = 0
        isPlayed = false
    }
    
//    func playMusic(nameMusic: String) {
//    func playMusic() {
//        let player : AVAudioPlayer?
//
//        let url = Bundle.main.url(forResource: "Cast_of_Pods", withExtension: ".mp3")!
//
//        do{
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.prepareToPlay()
//            player?.play()
//        }
//        catch{
//            print(error)
//
//        }
//    }
    
    func playSound(fileName: String) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension SoundOfNatureViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameSounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "soundCell", for: indexPath) as? SoundCell
        cell?.soundNameLabel.text = nameSounds[indexPath.row]
        cell?.soundTimeLabel.text = soundDurations[indexPath.row]
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(soundNames[indexPath.row])
        if (!isPlayed){
            isPlayed = true
            playSound(fileName: soundNames[indexPath.row])
            stopButton.alpha = 1
        } else {
            stopButton.alpha = 0
        }
    }
    
}
