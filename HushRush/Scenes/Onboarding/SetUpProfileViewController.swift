//
//  OnboardingViewController.swift
//  HushRush
//
//  Created by Wilbert Devin Wijaya on 20/06/22.
//

import UIKit
import Foundation

class SetUpProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var birthDateField: UITextField!
    @IBOutlet weak var deafPickerField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    let booleanPick = ["Iya", "Tidak"]
    var deafPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        //saveButton.addTarget(self, action: #selector(tapForSave), for: .touchUpInside)
        
        
        retrieveProfile()
        birthDatePicker()
        deafPicker()
 
    }
   /*
    @objc private func tapForSave() {
        UserDefaults.standard.set(nameField.text!, forKey: "NAME")
        UserDefaults.standard.set(birthDateField.text!, forKey: "DATE")
        UserDefaults.standard.set(deafPickerField.text!, forKey: "DEAF")
        
        //performSegue(withIdentifier: "goEmergencyContact", sender: self)
        

    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        ShadowViewButton.sharedInstance.setButtonShadow(button: saveButton)
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        UserDefaults.standard.set(nameField.text!, forKey: "NAME")
        UserDefaults.standard.set(birthDateField.text!, forKey: "DATE")
        UserDefaults.standard.set(deafPickerField.text!, forKey: "DEAF")
        
        if nameField.text == "" {
            print("Name Empty")
        } else if birthDateField.text == "" {
            print("Birth Empty")
        } else if deafPickerField.text == "" {
            print("Deaf Empty")
        } else {
            performSegue(withIdentifier: "goEmergencyContact", sender: self)
        }
        
    }
    
    @IBAction func didTapSkip(_ sender: UIButton) {
        performSegue(withIdentifier: "goEmergencyContact", sender: self)
        if nameField.text == "" {
            print("Name Empty")
        } else if birthDateField.text == "" {
            print("Birth Empty")
        } else if deafPickerField.text == "" {
            print("Deaf Empty")
        }
        
        UserDefaults.standard.set(nameField.text!, forKey: "NAME")
        UserDefaults.standard.set(birthDateField.text!, forKey: "DATE")
        UserDefaults.standard.set(deafPickerField.text!, forKey: "DEAF")
        
    }
    private func retrieveProfile() {
        let saveName = UserDefaults.standard.string(forKey: "NAME")
        let saveDate = UserDefaults.standard.string(forKey: "DATE")
        let saveDeafPick = UserDefaults.standard.string(forKey: "DEAF")
        
        //print(saveDate)
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        
        birthDateField.text = formatDate(Date: datePicker.date)
    }
    
    func formatDate(Date: Date) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: Date)
    }
    
    func birthDatePicker() {
            
        let datePicker = UIDatePicker()
        datePicker.datePickerMode =  .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        
        birthDateField.inputView = datePicker
 
    }
    
    func deafPicker() {
        
        deafPickerView.delegate = self
        deafPickerView.dataSource = self
        
        deafPickerField.inputView = deafPickerView
        
    }


}

extension SetUpProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return booleanPick.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return booleanPick[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        deafPickerField.text = booleanPick[row]
        //deafPickerField.resignFirstResponder()
    }
    
    
}

extension SetUpProfileViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SetUpProfileViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


