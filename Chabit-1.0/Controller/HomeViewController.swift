//
//  HomeViewController.swift
//  ChabitApp
//
//  Created by Fauzi Fauzi on 17/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit
import HealthKit

class HomeViewController: UIViewController {
    @IBOutlet weak var HRVProgressView: UIProgressView!
    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var emotionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var nameUser: String!
    
    let healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HRVProgressView.setProgress(0, animated: false)
        
        nameUser = UserDefaults.standard.string(forKey: "name")
        
        nameLabel.text = "Hello, \(nameUser!)"
        // Do any additional setup after loading the view.
        // MARK: CHECK HEALTH DATA AVAILIBILITY & REQUEST AUTHORIZATION
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            print("Health data is available")
            
            let allTypes = Set([HKObjectType.workoutType(),
                                HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                                HKObjectType.quantityType(forIdentifier: .heartRate)!])
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success {
                    // Handle the error here.
                    print(error!)
                } else {
                    print("SUCCESS :\(success)")
                    self.getHRVSampleQuery()
                }
            }
        }
    }
    

    
    
    // MARK: HRV & HR VALUE
    func getHRVSampleQuery() {
        let HRVType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN)
        let HRType = HKQuantityType.quantityType(forIdentifier: .heartRate)
        
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        let startDate = Date() - 7 * 24 * 60 * 60 // start date is a week from now
        //  Set the Predicates & Interval
        let predicate: NSPredicate? = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: HKQueryOptions.strictEndDate)
        
        let sampleQueryHRV = HKSampleQuery(sampleType: HRVType!, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { sampleQuery, results, error  in
            if(error == nil) {
                for result in results! {
                    //                    print("Startdate")
                    //                    print(result.startDate)
                    //                    print(result)
                    let r = result as! HKQuantitySample
                    let quantity = r.quantity
                    
                    let formater = DateFormatter()
                    formater.dateFormat = "h:mm a"
                    let updatedDate = formater.string(from: result.startDate)
                    let countHRVDouble = quantity.doubleValue(for: HKUnit(from: "ms"))
                    print(" countHRV \(countHRVDouble)")

                    var countHRV = Float(countHRVDouble)/65
                    print(" countHRV \(countHRV)")

                    if countHRV>1 {
                        countHRV = Float.random(in: 0..<0.2)
                        print(countHRV)
                    }
                    let countHRVtoProgress = 1-Float(countHRV)
                    print(" countHRVtoProgress \(countHRVtoProgress)")

                    DispatchQueue.main.async {
//                        self.dateLabel.text = "Today \(updatedDate)"
//                        self.HRVLabel.text = String(format: "HRV: %.2f ms", countHRVDouble)
                        if(countHRVtoProgress >= 0.7){
                            self.emotionLabel.text = "😔"
                        } else if(countHRVtoProgress > 0.3 && countHRVtoProgress < 0.7){
                            self.emotionLabel.text = "🙂"
                        } else {
                            self.emotionLabel.text = "😁"
                        }
                        self.HRVProgressView.setProgress(countHRVtoProgress, animated: true)
                    }
                    //Today 09.00 AM
                }
            }
        }
        
        let sampleQuery = HKSampleQuery(sampleType: HRType!, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { sampleQuery, results, error  in
            if(error == nil) {
                for result in results! {
                    let r = result as! HKQuantitySample
                    let quantity = r.quantity
                    let countHR = quantity.doubleValue(for: HKUnit(from: "count/min"))
                    print(" heartRate \(countHR)")
                    
                    DispatchQueue.main.async {
                        self.heartRateLabel.text = String(format: "❤️ HeartRate: %.1f ms", countHR)
                    }
                }
            }
        }
        healthStore.execute(sampleQueryHRV)
        healthStore.execute(sampleQuery)
    }
    
    // MARK: NEW FUNCTION
    
}
