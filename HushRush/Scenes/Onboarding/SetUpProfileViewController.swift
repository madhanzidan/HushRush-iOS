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
    @IBOutlet weak var deafPickerField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    let booleanPick = ["Tuli", "Tunarungu"]
    var deafPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        retrieveProfile()
        deafPicker()
        pickerView(deafPickerView, didSelectRow: 0, inComponent: 0)
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ShadowViewButton.sharedInstance.setButtonShadow(button: saveButton)
    }
    
    @IBAction func didTapSave(_ sender: UIButton) {
        UserDefaults.standard.set(nameField.text!, forKey: "NAME")
        UserDefaults.standard.set(deafPickerField.text!, forKey: "DEAF")
        
        if nameField.text == "" {
            print("Name Empty")
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
        } else if deafPickerField.text == "" {
            print("Deaf Empty")
        }
        
        UserDefaults.standard.set(nameField.text!, forKey: "NAME")
        UserDefaults.standard.set(deafPickerField.text!, forKey: "DEAF")
        
    }
    
    private func retrieveProfile() {
        UserDefaults.standard.string(forKey: "NAME")
        UserDefaults.standard.string(forKey: "DEAF")
        
    }

    
    func deafPicker() {
        
        deafPickerView.delegate = self
        deafPickerView.dataSource = self
        
        deafPickerField.inputView = deafPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()

        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SetUpProfileViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        deafPickerField.inputAccessoryView = toolBar

        
    }
    
    @objc func doneClick() {
        deafPickerField.resignFirstResponder()
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
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.deafPicker()
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


