//
//  ProgressViewController.swift
//  ChabitApp
//
//  Created by Fauzi Fauzi on 17/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit
import CoreData

class ProgressViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var progressActivitiesCollectionView: UICollectionView!
    
    @IBOutlet weak var sumDoneActivitiesLabel: UILabel!
    @IBOutlet weak var sumActivitiesLabel: UILabel!
    
    var morningList = [MorningActivity]()
    var afternoonList = [AfternoonActivity]()
    var nightList = [NightActivity]()
    
    var morningListIsChecked = [MorningActivity]()
    var afternoonListIsChecked = [AfternoonActivity]()
    var nightListIsChecked = [NightActivity]()
    
    
    var dayList = ["T","F","S","M","T","W","T"]
    var dateList = ["18","19","20","21","22","23","24"]
    var activityList = ["Morning","Afternoon","Night"]
    var activitiesCount = [3,3,3]
    var isCheckedCount = [3,1,0]
    var progressStatus = ["Achieved","In Progress","Soon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userNameLabel.text = UserDefaults.standard.string(forKey: "name")


        
//        loadDataSpecific()
//        loadDataSpecificIsDone()
//
//        progressActivitiesCollectionView.delegate = self
//        progressActivitiesCollectionView.dataSource = self
//
//        dayCollectionView.delegate = self
//        dayCollectionView.dataSource = self
//
//        dateCollectionView.delegate = self
//        dateCollectionView.dataSource = self
//
//        activitiesCount.append(morningList.count)
//        activitiesCount.append(afternoonList.count)
//        activitiesCount.append(nightList.count)
//
//        isCheckedCount.append(morningListIsChecked.count)
//        isCheckedCount.append(afternoonListIsChecked.count)
//        isCheckedCount.append(nightListIsChecked.count)
//
//
//        print(activitiesCount)
//
//        let sumActivities = activitiesCount.reduce(0, +)
//        let sumIsCheckedCount = isCheckedCount.reduce(0, +)
//
//        sumDoneActivitiesLabel.text = String(sumIsCheckedCount)
//        sumActivitiesLabel.text = "/\(String(sumActivities))"



    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDataSpecific()
        loadDataSpecificIsDone()
        
        progressActivitiesCollectionView.delegate = self
        progressActivitiesCollectionView.dataSource = self
        
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        
        activitiesCount.append(morningList.count)
        activitiesCount.append(afternoonList.count)
        activitiesCount.append(nightList.count)
        
        isCheckedCount.append(morningListIsChecked.count)
        isCheckedCount.append(afternoonListIsChecked.count)
        isCheckedCount.append(nightListIsChecked.count)
        
        
        print(activitiesCount)
        print(isCheckedCount)

        
        let sumActivities = activitiesCount.reduce(0, +)
        let sumIsCheckedCount = isCheckedCount.reduce(0, +)
        
        sumDoneActivitiesLabel.text = String(sumIsCheckedCount)
        sumActivitiesLabel.text = "/\(String(sumActivities))"
        
        progressActivitiesCollectionView.reloadData()
        
        
    }
    
    //MARK : COBA UBAH
    
}

extension ProgressViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cellCount = 0
        if collectionView == self.progressActivitiesCollectionView {
            cellCount = activityList.count
        } else if collectionView == self.dayCollectionView {
            cellCount = dayList.count
        } else {
            cellCount = dateList.count
        }
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.progressActivitiesCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressCell", for: indexPath) as? ProgressActivitiesCell
        cell?.activitiesNameLabel.text = activityList[indexPath.row]
        cell?.activitiesCountLabel.text = "/\(activitiesCount[indexPath.row])"
        cell?.isCheckedCountLabel.text = String(isCheckedCount[indexPath.row])
        cell?.progressStatusLabel.text = progressStatus[indexPath.row]

        return cell!
        } else if collectionView == self.dayCollectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as? DayProgressViewCell
            
            cellA?.dayProgressLabel.text = dayList[indexPath.row]
            return cellA!

        } else{
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as? DateProgressViewCell
            cellB?.dateProgressLabel.text = dateList[indexPath.row]
            if indexPath.row == 3 {
                cellB?.dateProgressLabel.backgroundColor = #colorLiteral(red: 0.2623271942, green: 0.8445391655, blue: 0.7115685344, alpha: 1)
                cellB?.dateProgressLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            }
            
            return cellB!

        }
            
    }
    
    
    func loadDataSpecific(){
        
        activitiesCount.removeAll()
        
            let request1: NSFetchRequest<MorningActivity> = MorningActivity.fetchRequest()
            let predicate1 = NSPredicate(format: "morningIsAdd == true")
            
            request1.predicate = predicate1
            
            do{
                morningList = try context.fetch(request1)
            }catch{
                print("ERROR LOAD MORNING DATA \(error)")
            }
            
            let request2: NSFetchRequest<AfternoonActivity> = AfternoonActivity.fetchRequest()
            let predicate2 = NSPredicate(format: "afternoonIsAdd == true")
            
            request2.predicate = predicate2
            
            do{
                afternoonList = try context.fetch(request2)
            }catch{
                print("ERROR LOAD AFTERNOON DATA \(error)")
            }
        
            let request3: NSFetchRequest<NightActivity> = NightActivity.fetchRequest()
            let predicate3 = NSPredicate(format: "nightIsAdd == true")
            
            request3.predicate = predicate3
            
            do{
                nightList = try context.fetch(request3)

            }catch{
                print("ERROR LOAD NIGHT DATA \(error)")
            }
    }
    
    func loadDataSpecificIsDone(){
        
        isCheckedCount.removeAll()

        
        let request1: NSFetchRequest<MorningActivity> = MorningActivity.fetchRequest()
        let predicate1 = NSPredicate(format: "morningIsDone == true")
        
        request1.predicate = predicate1
        
        do{
            morningListIsChecked = try context.fetch(request1)
        }catch{
            print("ERROR LOAD MORNING DATA \(error)")
        }
        
        let request2: NSFetchRequest<AfternoonActivity> = AfternoonActivity.fetchRequest()
        let predicate2 = NSPredicate(format: "afternoonIsDone == true")
        
        request2.predicate = predicate2
        
        do{
            afternoonListIsChecked = try context.fetch(request2)
        }catch{
            print("ERROR LOAD AFTERNOON DATA \(error)")
        }
        
        let request3: NSFetchRequest<NightActivity> = NightActivity.fetchRequest()
        let predicate3 = NSPredicate(format: "nightIsDone == true")
        
        request3.predicate = predicate3
        
        do{
            nightListIsChecked = try context.fetch(request3)
            
        }catch{
            print("ERROR LOAD NIGHT DATA \(error)")
        }
    }
}
