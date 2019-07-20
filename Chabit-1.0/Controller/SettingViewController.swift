//
//  SettingViewController.swift
//  ChabitApp
//
//  Created by Fauzi Fauzi on 17/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    var cellSettings = ["Notification","Sound","Alarm"]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        userNameLabel.text = UserDefaults.standard.string(forKey: "name")
    }
    
    //MARK : COBA UBAH
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell", for: indexPath)
        cell.textLabel?.text = cellSettings[indexPath.row]
        
        return cell
    }
    
}
