//
//  MeditationViewController.swift
//  Chabit-1.0
//
//  Created by Fauzi Fauzi on 19/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit

class MeditationViewController: UIViewController {
    @IBOutlet weak var buttonPrepare: UIButton!
    @IBOutlet weak var buttonMeditating: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonPrepare.layer.cornerRadius = 15
        buttonMeditating.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
