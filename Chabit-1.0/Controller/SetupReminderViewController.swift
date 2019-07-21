//
//  SetupReminderViewController.swift
//  Chabit-1.0
//
//  Created by Pramahadi Tama Putra on 18/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit
import UserNotifications

class SetupReminderViewController: UIViewController, UITextFieldDelegate {
    
    var hour:Int = 0
    var minute:Int = 0
    
    @IBOutlet weak var reminderTF: UITextField!{
        didSet{
            reminderTF.borderStyle = .roundedRect
            reminderTF.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            reminderTF.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //         Step 1: Ask for permission
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        }
        reminderTF.delegate = self
        
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(SetupReminderViewController.dismissPicker))
        
        reminderTF.inputAccessoryView = toolBar
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissPicker(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func setTimePicker(_ sender: UIButton) {
        setReminderCustom(hour: hour, minute: minute)
    }
    
    @IBAction func reminderTFEdit(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = .time
        sender.inputView = datePickerView
        
        
        datePickerView.addTarget(self, action: #selector(SetupReminderViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let datePicker = sender.date
        let date = Calendar.current.dateComponents([.hour, .minute], from: datePicker)
        
        hour = date.hour!
        minute = date.minute!
        
        print("\(hour) : \(minute)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        reminderTF.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func setReminderCustom(hour:Int,minute:Int){
        
        
        var contentMorning = UNMutableNotificationContent()
        var contentAfternoon = UNMutableNotificationContent()
        var contentNight = UNMutableNotificationContent()
        
        
        //Content Pagi
        contentMorning.title = "Don't Forget Hadi!"
        contentMorning.body = "6 Activity Left, Check it out !"
        contentMorning.subtitle = "Morning Routine Activity"
        contentMorning.sound = .default
        
        //Content Siang
        contentAfternoon.title = "Don't Forget Hadi!"
        contentAfternoon.body = "6 Activity Left, Check it out !"
        contentAfternoon.subtitle = "Afternoon Routine Activity"
        contentAfternoon.sound = .default
        
        //Content Malem
        contentNight.title = "Don't Forget Hadi!"
        contentNight.body = "6 Activity Left, Check it out !"
        contentNight.subtitle = "Night Routine Activity"
        contentNight.sound = .default
        
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        
        var componentMorning = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        // Change the time to 7:00:00 in your locale
        componentMorning.hour = hour
        componentMorning.minute = minute
        componentMorning.second = 10
        
        var componentAfternoon = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        // Change the time to 7:00:00 in your locale
        componentAfternoon.hour = 17
        componentAfternoon.minute = 52
        componentAfternoon.second = 30
        
        var componentNight = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        // Change the time to 7:00:00 in your locale
        componentNight.hour = 17
        componentNight.minute = 52
        componentNight.second = 40
        
        
        let dateMorning = gregorian.date(from: componentMorning)!
        let dateAfternoon = gregorian.date(from: componentAfternoon)!
        let dateNight = gregorian.date(from: componentNight)!
        
        let triggerDailyMorning = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateMorning)
        let triggerDailyAfternoon = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateAfternoon)
        let triggerDailyNight = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateNight)
        
        let triggerMorning = UNCalendarNotificationTrigger(dateMatching: triggerDailyMorning, repeats: true)
        let triggerAfternoon = UNCalendarNotificationTrigger(dateMatching: triggerDailyAfternoon, repeats: true)
        let triggerNight = UNCalendarNotificationTrigger(dateMatching: triggerDailyNight, repeats: true)
        
        let uuidString1 = UUID().uuidString
        let uuidString2 = UUID().uuidString
        let uuidString3 = UUID().uuidString
        
        let requestMorning = UNNotificationRequest(identifier: uuidString1, content: contentMorning, trigger: triggerMorning)
        let requestAfternoon = UNNotificationRequest(identifier: uuidString2, content: contentAfternoon, trigger: triggerAfternoon)
        let requestNight = UNNotificationRequest(identifier: uuidString3, content: contentNight, trigger: triggerNight)
        
        let center = UNUserNotificationCenter.current()
        
        print("INSIDE NOTIFICATION")
        
        center.add(requestMorning) { (error) in
            //             Check the error parameter and handle any errors
        }
        center.add(requestAfternoon) { (error) in
            //             Check the error parameter and handle any errors
        }
        center.add(requestNight) { (error) in
            //             Check the error parameter and handle any errors
        }
        
    }
    
}

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
