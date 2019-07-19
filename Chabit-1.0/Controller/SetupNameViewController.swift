//
//  SetupNameViewController.swift
//  Chabit-1.0
//
//  Created by Pramahadi Tama Putra on 18/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit

class SetupNameViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    @IBOutlet weak var nameTF: UITextField!{
        didSet{
            nameTF.borderStyle = .roundedRect
            nameTF.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            nameTF.layer.cornerRadius = 10
        }
    }
    
    @IBAction func saveName(_ sender: UIButton) {
        setName()
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
    }
    
    func setName(){
        UserDefaults.standard.set(nameTF.text, forKey: "name")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTF.delegate = self
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        

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
