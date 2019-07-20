//
//  MorningActivitiesViewController.swift
//  CardViewTestLikeAppStore
//
//  Created by Willa on 17/07/19.
//  Copyright © 2019 WillaSaskara. All rights reserved.
//

import UIKit
import CoreData

class MorningActivitiesViewController: UIViewController {
    
    
    @IBOutlet weak var viewImage: CardView!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var morningActivitiesList = [MorningActivityItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
        loadData()
        
        viewImage.layer.shadowColor = #colorLiteral(red: 0, green: 0.7641252279, blue: 0.8642910123, alpha: 1)
        
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        

        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    

    @IBAction func addButtonTapped(_ sender: Any) {
        
    performSegue(withIdentifier: "todAddItem", sender: self)
        
        
        
    }
    
}


extension MorningActivitiesViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    // MARK : -Tableview datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return morningActivitiesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        
        cell.cellTextLabel.text = morningActivitiesList[indexPath.row].activityName
        cell.minuteLabel.text = "1 minute"
        cell.accessoryType = morningActivitiesList[indexPath.row].isDone ? .checkmark : .none
        //cell.accessoryType = morningActivitiesList[indexPath.row].isDone ? .checkmark : .none
//        cell.textLabel?.text = morningActivitiesList[indexPath.row].activityName
//        cell.accessoryType = morningActivitiesList[indexPath.row].isDone ? .checkmark : .none

        return cell
        
    }
    
    
    // MARK : - TableView Deletage
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadData()
        
        let item = morningActivitiesList[indexPath.row]
        
        if item.isDone == false{
            
            item.isDone = true
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }else{
            item.isDone = false
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        
        saveData()
        tableView.reloadData()
    
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                
                
                self.morningActivitiesList[indexPath.row].isAdd = false
                
                self.morningActivitiesList[indexPath.row].isDone = false
                self.saveData()
            }
            
        }
    }
    
    
    func saveData(){
        try? context.save()
        loadData()
    }
    
    func loadData(){
        
        let request :  NSFetchRequest<MorningActivityItem> = MorningActivityItem.fetchRequest()
        
        let predicate = NSPredicate(format: "isAdd == true")
        
        request.predicate = predicate
        
        
        do{
            morningActivitiesList =  try context.fetch(request)
        }catch{
            print("failed to load data \(error)")
        }
        
        tableView.reloadData()
        
        
    }
    
    
}
