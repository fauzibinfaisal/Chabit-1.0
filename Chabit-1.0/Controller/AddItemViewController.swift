//
//  AddItemViewController.swift
//  Chabit-1.0
//
//  Created by Fauzi Fauzi on 20/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit
import CoreData


class AddItemViewController: UIViewController {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var morningActivityAllList = [MorningActivityItem]()
    

    @IBOutlet weak var addItemTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!)
        
        loadData()
        
        addItemTableView.delegate = self
        addItemTableView.dataSource = self
        addItemTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        
        loadStaticItem()
        
        let searchBarController =  UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchBarController
        
        navigationItem.searchController?.searchBar.delegate =  self
        
        
        addItemTableView.rowHeight = UITableView.automaticDimension
        addItemTableView.estimatedRowHeight = 600
        
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func saveData(){
        try? context.save()
        loadData()
    }
    
    func loadData(){
        
        let request :  NSFetchRequest<MorningActivityItem> = MorningActivityItem.fetchRequest()
        
        let descriptors : NSSortDescriptor = NSSortDescriptor(key: "activityName", ascending: true)
        
        request.sortDescriptors = [descriptors]
        
        
        do{
            morningActivityAllList =  try context.fetch(request)
        }catch{
            print("failed to load data \(error)")
        }
        
        addItemTableView.reloadData()
        
    }
    
    
    
    
    func loadStaticItem(){
        if morningActivityAllList.count == 0 {
            
            let data = HealthlyHabitsData()
            
            for i in 0..<data.data.count{
                
                let newItem = MorningActivityItem(context: context)
                
                newItem.activityName = data.data[i]
                newItem.isAdd = false
                newItem.isDone = false
                
                saveData()
                
            }
            
        }
    }
    
    
    
    @IBAction func addYoursButtonTapped(_ sender: Any) {
        
        
        //create the local variable that handle the alert text field
        var textField = UITextField()
        
        //create the alert controler
        let alert = UIAlertController(title: "Add Your item", message: "", preferredStyle: .alert)
        
        //create the alert action
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            print("you pressed the add button ")
            
            //set the textfielnd popup if they are not blank
            if textField.text! != "" {
                
                
                let newItem = MorningActivityItem(context: self.context)
                newItem.activityName = textField.text!
                newItem.isDone = false
                newItem.isAdd = false
                
                self.saveData()
                
            }
            
            
            
            //reload the tableview delegate each button pressed
            self.addItemTableView.reloadData()
            
        }
        
        let action2 = UIAlertAction(title: "Cancle", style: .cancel) { (action) in
            //cancled when user taps outside
        }
        
        
        
        
        //add the text field to the alert controller that we created before
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add yours!"
            textField = alertTextField
        }
        
        
        //add the action to the alert controller that we created before then set action with the UIAlertAction (we have created the alert action in line 92)
        alert.addAction(action)
        alert.addAction(action2)
        
        //finaly present or call the alert with this code
        present(alert, animated: true, completion: nil)
        
        addItemTableView.reloadData()
        loadData()
        
        
        
        
        
        //
        //                print("YOU PRESSED THE ADD BUTTON")
        //
        //
        //
        //                let newItem = MorningActivityItem(context: self.context)
        //
        //                let alert = UIAlertController(title: "Add your Activity list", message: "fill the text here", preferredStyle: .alert)
        //
        //
        //
        //
        //                let action = UIAlertAction(title: "add", style: .default) { (alert) in
        //
        //                    if textField.text != ""{
        //
        //                        var textField = UITextField()
        //
        //                        newItem.activityName = textField.text!
        //                        newItem.isDone = false
        //
        //                        self.saveData()
        //                        self.tableView.reloadData()
        //
        //                        //debug
        //                        print("YANG DITULIS DI TEXT FIELD = \(newItem.activityName!)")
        //                        print("YOU PRESSED THE ACTION THEN SAVED THE DATA")
        //                    }
        //
        //
        //                }
        //
        //                alert.addTextField { (textFieldResult) in
        //
        //                    textFieldResult.placeholder = "Add yours here"
        //                    textField = textFieldResult
        //                }
        //
        //                alert.addAction(action)
        //                present(alert, animated: true)
        //
    }
    
    
    
    
    
    
}


extension AddItemViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return morningActivityAllList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addItemTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.cellTextLabel.text = morningActivityAllList[indexPath.row].activityName
        cell.accessoryType = morningActivityAllList[indexPath.row].isAdd ? .checkmark : .none
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadData()
        
        let item = morningActivityAllList[indexPath.row]
        
        if item.isAdd == false{
            
            item.isAdd = true
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }else{
            item.isAdd = false
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        
        saveData()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            let commit = morningActivityAllList[indexPath.row]
            context.delete(commit)
            morningActivityAllList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //                self.saveData()
            //            }
            
            
            
            DispatchQueue.main.async {
                self.loadData()
                self.saveData()
            }
            
            
        }
        
    }
    
    
    
}



extension AddItemViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadData()
            //            DispatchQueue.main.async {
            //                searchBar.resignFirstResponder()
            //            }
        }else{
            loadData()
            let request: NSFetchRequest<MorningActivityItem> = MorningActivityItem.fetchRequest()
            
            let descriptors : NSSortDescriptor = NSSortDescriptor(key: "activityName", ascending: true)
            
            let predicate  = NSPredicate(format: "activityName CONTAINS[cd] %@", searchBar.text!)
            
            
            request.predicate = predicate
            request.sortDescriptors = [descriptors]
            
            //let request : NSFetchRequest<MorningActivityItem> = MorningActivityItem.fetchRequest()
            
            do{
                morningActivityAllList =  try context.fetch(request)
            }catch{
                print("failed to load data \(error)")
            }
            
            addItemTableView.reloadData()
            
        }
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        loadData()
    }
    
    
}

