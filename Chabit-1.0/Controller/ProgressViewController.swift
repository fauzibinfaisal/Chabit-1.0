//
//  ProgressViewController.swift
//  ChabitApp
//
//  Created by Fauzi Fauzi on 17/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var dayCollectionView: UICollectionView!
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var progressActivitiesCollectionView: UICollectionView!
    
    @IBOutlet weak var sumDoneActivitiesLabel: UILabel!
    @IBOutlet weak var sumActivitiesLabel: UILabel!
    
    
    
    var dayList = ["T","F","S","M","T","W","T"]
    var dateList = ["18","19","20","21","22","23","24"]
    var activityList = ["Morning","Afternoon","Night"]
    var activitiesCount = [3,3,1]
    var isCheckedCount = [3,1,0]
    var progressStatus = ["Achieved","In Progress","Soon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userNameLabel.text = UserDefaults.standard.string(forKey: "name")
        
        progressActivitiesCollectionView.delegate = self
        progressActivitiesCollectionView.dataSource = self
        
        dayCollectionView.delegate = self
        dayCollectionView.dataSource = self
        
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self

        let sumActivities = activitiesCount.reduce(0, +)
        let sumIsCheckedCount = isCheckedCount.reduce(0, +)
        
        sumDoneActivitiesLabel.text = String(sumIsCheckedCount)
        sumActivitiesLabel.text = "/\(String(sumActivities))"


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
}
