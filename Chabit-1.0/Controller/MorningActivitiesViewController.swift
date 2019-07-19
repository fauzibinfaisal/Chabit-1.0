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

        // Do any additional setup after loading the view.
        loadData()
        
        viewImage.layer.shadowColor = #colorLiteral(red: 0, green: 0.7641252279, blue: 0.8642910123, alpha: 1)
        
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        

        
    
    }
    

    @IBAction func addButtonTapped(_ sender: Any) {
        
        //create the local variable that handle the alert text field
        var textField = UITextField()
        
        //create the alert controler
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        //create the alert action
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            print("you pressed the add button ")
            
            //set the textfielnd popup if they are not blank
            if textField.text! != "" {
                
                    
                    let newItem = MorningActivityItem(context: self.context)
                    newItem.activityName = textField.text!
                    newItem.isDone = false
                
                    self.saveData()
                
                }
                
            
            
            //reload the tableview delegate each button pressed
            self.tableView.reloadData()
            
        }
        
        
        //add the text field to the alert controller that we created before
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add yours!"
            textField = alertTextField
        }
        
        
        //add the action to the alert controller that we created before then set action with the UIAlertAction (we have created the alert action in line 92)
        alert.addAction(action)
        
        //finaly present or call the alert with this code
        present(alert, animated: true, completion: nil)
        
        
        
    }
        
        
//        print("YOU PRESSED THE ADD BUTTON")
//
//
//
//        let newItem = MorningActivityItem(context: self.context)
//
//        let alert = UIAlertController(title: "Add your Activity list", message: "fill the text here", preferredStyle: .alert)
//
//
//
//
//        let action = UIAlertAction(title: "add", style: .default) { (alert) in
//
//            if textField.text != ""{
//
//                var textField = UITextField()
//
//                newItem.activityName = textField.text!
//                newItem.isDone = false
//
//                self.saveData()
//                self.tableView.reloadData()
//
//                //debug
//                print("YANG DITULIS DI TEXT FIELD = \(newItem.activityName!)")
//                print("YOU PRESSED THE ACTION THEN SAVED THE DATA")
//            }
//
//
//        }
//
//        alert.addTextField { (textFieldResult) in
//
//            textFieldResult.placeholder = "Add yours here"
//            textField = textFieldResult
//        }
//
//        alert.addAction(action)
//        present(alert, animated: true)
//
//
//    }

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
        
    
            
            self.morningActivitiesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            saveData()
            tableView.reloadData()
        }
    }
    
    
    func saveData(){
        try? context.save()
        loadData()
    }
    
    func loadData(){
        
        let request :  NSFetchRequest<MorningActivityItem> = MorningActivityItem.fetchRequest()
        
        do{
            morningActivitiesList =  try context.fetch(request)
        }catch{
            print("failed to load data \(error)")
        }
        
        tableView.reloadData()
        
        
    }
    
    
}
