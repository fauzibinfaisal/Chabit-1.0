//
//  SetupReminderViewController.swift
//  Chabit-1.0
//
//  Created by Pramahadi Tama Putra on 18/07/19.
//  Copyright © 2019 C2G10. All rights reserved.
//

import UIKit

class SetupReminderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var reminderTF: UITextField!{
        didSet{
            reminderTF.borderStyle = .roundedRect
            reminderTF.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            reminderTF.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    @IBAction func reminderTFEdit(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(SetupReminderViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeStyle = DateFormatter.Style.medium
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
