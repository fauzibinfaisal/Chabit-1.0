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
    
    
    var activityTime: String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var viewImage: CardView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var iconActivityImage: UIImageView!
    
    

    
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        
        loadDataSpecific()
        
        viewImage.layer.shadowColor = #colorLiteral(red: 0, green: 0.7641252279, blue: 0.8642910123, alpha: 1)
        
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        

        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadDataSpecific()
        tableView.reloadData()
        tabBarController?.tabBar.isHidden = true
        self.title = activityTime! + " activity"
        
        if activityTime == "morning"{
            self.iconActivityImage.image = UIImage(named: "morningActivities")
        }else if activityTime == "afternoon"{
            self.iconActivityImage.image = UIImage(named: "afternoonActivities")
        }else if activityTime == "night"{
            self.iconActivityImage.image = UIImage(named: "nightActivities")
        }
    }
    

    @IBAction func addButtonTapped(_ sender: Any) {
        
    performSegue(withIdentifier: "todAddItem", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! AddItemViewController
        destinationVC.activityTime = activityTime!
    }
    
    
    
}


extension MorningActivitiesViewController : UITableViewDelegate, UITableViewDataSource{
    
    
    // MARK : -Tableview datasource
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
            cell.accessoryType = morningActivityList[indexPath.row].morningIsDone ? .checkmark : .none
            return cell
            
        }else if activityTime == "afternoon"{
            cell.cellTextLabel.text = afternoonActivityList[indexPath.row].afternoonName!
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            cell.minuteLabel.text = dateFormater.string(from: afternoonActivityList[indexPath.row].afternoonDate! as Date)
            cell.accessoryType = afternoonActivityList[indexPath.row].afternoonIsDone ? .checkmark : .none
            return cell
            
        }else if activityTime == "night"{
            cell.cellTextLabel.text = nightActivityList[indexPath.row].nightName!
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd-MM-yyyy"
            cell.minuteLabel.text = dateFormater.string(from: nightActivityList[indexPath.row].nightDate! as Date)
            cell.accessoryType = nightActivityList[indexPath.row].nightIsDone ? .checkmark : .none
            return cell
        }
        
        return cell
        
    }
    
    
    // MARK : - TableView Deletage
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //loadDataSpecific()
        
        if activityTime == "morning"{
            let item = morningActivityList[indexPath.row]
            if item.morningIsDone == false{
                item.morningIsDone = true
                
            }else{
                item.morningIsDone = false
                
            }
        }else if activityTime == "afternoon"{
            let item = afternoonActivityList[indexPath.row]
            if item.afternoonIsDone == false{
                item.afternoonIsDone = true
                
            }else{
                item.afternoonIsDone = false
                
            }
        }else if activityTime == "night"{
            let item = nightActivityList[indexPath.row]
            if item.nightIsDone == false{
                item.nightIsDone = true
                
            }else{
                item.nightIsDone = false
                
            }
        }
        
        saveData()
        loadDataSpecific()
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                if self.activityTime == "morning"{
                    self.morningActivityList[indexPath.row].morningIsAdd = false
                    self.morningActivityList[indexPath.row].morningIsDone = false
                }else if self.activityTime == "afternoon"{
                    self.afternoonActivityList[indexPath.row].afternoonIsAdd = false
                    self.afternoonActivityList[indexPath.row].afternoonIsDone = false
                }else if self.activityTime == "night"{
                    self.nightActivityList[indexPath.row].nightIsAdd = false
                    self.nightActivityList[indexPath.row].nightIsDone = false
                }
                self.saveData()
            }
            
        }
    }
    
    
    func saveData(){
        try? context.save()
        loadDataSpecific()
    }
    
    func loadDataSpecific(){
        
        if activityTime == "morning"{
            
            let request: NSFetchRequest<MorningActivity> = MorningActivity.fetchRequest()
            let predicate = NSPredicate(format: "morningIsAdd == true")
            
            request.predicate = predicate
            
            do{
                morningActivityList = try context.fetch(request)
            }catch{
                print("ERROR LOAD MORNING DATA \(error)")
            }
            
        }else if activityTime == "afternoon"{
            
            let request: NSFetchRequest<AfternoonActivity> = AfternoonActivity.fetchRequest()
            let predicate = NSPredicate(format: "afternoonIsAdd == true")
            
            request.predicate = predicate
            
            do{
                afternoonActivityList = try context.fetch(request)
            }catch{
                print("ERROR LOAD AFTERNOON DATA \(error)")
            }
            
        }else if activityTime == "night" {
            let request: NSFetchRequest<NightActivity> = NightActivity.fetchRequest()
            let predicate = NSPredicate(format: "nightIsAdd == true")
            
            request.predicate = predicate
            
            do{
                nightActivityList = try context.fetch(request)
            }catch{
                print("ERROR LOAD NIGHT DATA \(error)")
            }
        }
        
        tableView.reloadData()
        
    }
    
    
}
