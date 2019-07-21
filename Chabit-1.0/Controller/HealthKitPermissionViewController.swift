//
//  HealthKitPermissionViewController.swift
//  Chabit-1.0
//
//  Created by Fauzi Fauzi on 22/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitPermissionViewController: UIViewController {
    @IBOutlet weak var healthkitButton: CustomButton!
    
    var isGranted = false
    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            print("Health data is available")
            
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                                HKObjectType.quantityType(forIdentifier: .heartRate)!])
            healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
                if !success {
                    // Handle the error here.
                    print(error!)
                } else {
                    print("SUCCESS :\(success)")
                    self.isGranted = true
                    
                }
            }
        }
    }
}
