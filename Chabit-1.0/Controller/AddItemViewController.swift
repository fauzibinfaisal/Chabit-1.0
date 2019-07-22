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
    
    
    var activityTime: String?
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var morningActivityList: [MorningActivity] = {
        
        if activityTime == "morning"{
            return [MorningActivity]()
        }
        return [MorningActivity]()
    }()
    
    lazy var afternoonActivityList: [AfternoonActivity] = {
        if activityTime == "afternoon"{
            return [AfternoonActivity]()
        }
        return [AfternoonActivity]()
    }()
    
    lazy var nightActivityList: [NightActivity] = {
        if activityTime == "night"{
            return [NightActivity]()
        }
        return [NightActivity]()
    }()
    

    @IBOutlet weak var addItemTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!)
        
        loadDataSpecific()
        
        addItemTableView.delegate = self
        addItemTableView.dataSource = self
        addItemTableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        
        
        let searchBarController =  UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchBarController
        
        navigationItem.searchController?.searchBar.delegate =  self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tabBarController?.tabBar.isHidden = true
        self.title = "add " + activityTime! + " activity"
        
        
        
    }
    
    
    
    // MARK : - function for core data
    
    func saveData(){
        try? context.save()
        //loadData()
    }
    
    func loadDataSpecific(){
        
        if activityTime == "morning"{
            
            let request: NSFetchRequest<MorningActivity> = MorningActivity.fetchRequest()
            
            do{
                morningActivityList = try context.fetch(request)
            }catch{
                print("ERROR LOAD MORNING DATA \(error)")
            }
            
        }else if activityTime == "afternoon"{
            
            let request: NSFetchRequest<AfternoonActivity> = AfternoonActivity.fetchRequest()
            
            do{
                afternoonActivityList = try context.fetch(request)
            }catch{
                print("ERROR LOAD AFTERNOON DATA \(error)")
            }
            
        }else if activityTime == "night" {
            let request: NSFetchRequest<NightActivity> = NightActivity.fetchRequest()
            
            do{
                nightActivityList = try context.fetch(request)
            }catch{
                print("ERROR LOAD NIGHT DATA \(error)")
            }
        }
        
        addItemTableView.reloadData()
        
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
                
                if self.activityTime == "morning"{
                    let newItem = MorningActivity(context: self.context)
                    newItem.morningName = textField.text!
                    newItem.morningIsAdd = false
                    newItem.morningIsDone = false
                    newItem.morningDate = Date()
                }else if self.activityTime == "afternoon"{
                    let newItem = AfternoonActivity(context: self.context)
                    newItem.afternoonName = textField.text!
                    newItem.afternoonIsAdd = false
                    newItem.afternoonIsDone = false
                    newItem.afternoonDate = Date()
                }else if self.activityTime == "night"{
                    let newItem = NightActivity(context: self.context)
                    newItem.nightName = textField.text!
                    newItem.nightIsAdd = false
                    newItem.nightIsDone = false
                    newItem.nightDate = Date()
                }
                
                
                
                self.saveData()
                self.loadDataSpecific()
                
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
        loadDataSpecific()
        
    }
    
    
    
    
    
    
}


extension AddItemViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if activityTime == "morning"{
            return morningActivityList.count
        }else if activityTime == "afternoon"{
            return afternoonActivityList.count
        }else if activityTime == "night"{
            return nightActivityList.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        
        if activityTime == "morning"{
            cell.cellTextLabel.text = morningActivityList[indexPath.row].morningName
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            cell.minuteLabel.text = dateFormater.string(from: morningActivityList[indexPath.row].morningDate! as Date)
            cell.accessoryType = morningActivityList[indexPath.row].morningIsAdd ? .checkmark : .none
            return cell
            
        }else if activityTime == "afternoon"{
            cell.cellTextLabel.text = afternoonActivityList[indexPath.row].afternoonName!
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            cell.minuteLabel.text = dateFormater.string(from: afternoonActivityList[indexPath.row].afternoonDate! as Date)
            cell.accessoryType = afternoonActivityList[indexPath.row].afternoonIsAdd ? .checkmark : .none
            return cell
            
        }else if activityTime == "night"{
            cell.cellTextLabel.text = nightActivityList[indexPath.row].nightName!
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            cell.minuteLabel.text = dateFormater.string(from: nightActivityList[indexPath.row].nightDate! as Date)
            cell.accessoryType = nightActivityList[indexPath.row].nightIsAdd ? .checkmark : .none
            return cell
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loadDataSpecific()
        
        if activityTime == "morning"{
            let item = morningActivityList[indexPath.row]
            if item.morningIsAdd == false{
                item.morningIsAdd = true
                
            }else{
                item.morningIsAdd = false
                
            }
        }else if activityTime == "afternoon"{
            let item = afternoonActivityList[indexPath.row]
            if item.afternoonIsAdd == false{
                item.afternoonIsAdd = true
                
            }else{
                item.afternoonIsAdd = false
                
            }
        }else if activityTime == "night"{
            let item = nightActivityList[indexPath.row]
            if item.nightIsAdd == false{
                item.nightIsAdd = true
                
            }else{
                item.nightIsAdd = false
                
            }
            
        }
        
        saveData()
        loadDataSpecific()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            if activityTime == "morning"{
                let commit = morningActivityList[indexPath.row]
                context.delete(commit)
                morningActivityList.remove(at: indexPath.row)
            }else if activityTime == "afternoon"{
                let commit = afternoonActivityList[indexPath.row]
                context.delete(commit)
                afternoonActivityList.remove(at: indexPath.row)
            }else if activityTime == "night"{
                let commit = nightActivityList[indexPath.row]
                context.delete(commit)
                nightActivityList.remove(at: indexPath.row)
            }
            
            
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.saveData()
                
            }
            
        }
        
    }
    
    
    
}



extension AddItemViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadDataSpecific()
            //            DispatchQueue.main.async {
            //                searchBar.resignFirstResponder()
            //            }
        }else{
            loadDataSpecific()
            if activityTime == "morning"{
                let request: NSFetchRequest<MorningActivity> = MorningActivity.fetchRequest()
                
                let descriptors : NSSortDescriptor = NSSortDescriptor(key: "morningName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
                
                let predicate  = NSPredicate(format: "morningName CONTAINS[cd] %@", searchBar.text!)
                
                
                request.predicate = predicate
                request.sortDescriptors = [descriptors]
                
                do{
                    morningActivityList =  try context.fetch(request)
                }catch{
                    print("failed to load data \(error)")
                }
                
            }else if activityTime == "afternoon"{
                let request: NSFetchRequest<AfternoonActivity> = AfternoonActivity.fetchRequest()
                
                let descriptors : NSSortDescriptor = NSSortDescriptor(key: "afternoonName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
                
                let predicate  = NSPredicate(format: "afternoonName CONTAINS[cd] %@", searchBar.text!)
                
                request.predicate = predicate
                request.sortDescriptors = [descriptors]
                
                do{
                    afternoonActivityList =  try context.fetch(request)
                }catch{
                    print("failed to load data \(error)")
                }
                
            }else if activityTime == "night"{
                let request: NSFetchRequest<NightActivity> = NightActivity.fetchRequest()
                
                let descriptors : NSSortDescriptor = NSSortDescriptor(key: "nightName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
                
                let predicate  = NSPredicate(format: "nightName CONTAINS[cd] %@", searchBar.text!)
                
                
                request.predicate = predicate
                request.sortDescriptors = [descriptors]
                
                do{
                    nightActivityList =  try context.fetch(request)
                }catch{
                    print("failed to load data \(error)")
                }
            }
            
            addItemTableView.reloadData()
            
        }
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        loadDataSpecific()
    }
    
    
    
    
    
}
