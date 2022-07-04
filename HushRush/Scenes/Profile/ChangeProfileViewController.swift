//
//  ChangeProfileViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 28/06/22.
//

import UIKit

class ChangeProfileViewController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var birthdateInput: UITextField!
    @IBOutlet weak var deafnessStatusInput: UITextField!
    
    var name: String? = UserDefaults.standard.string(forKey: "NAME")
    var birthday: String? = UserDefaults.standard.string(forKey: "DATE")
    var deafStatus: String? = UserDefaults.standard.string(forKey: "DEAF")
    
    let status = [" ", "Tuli", "Tunarungu"]
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        nameInput.returnKeyType = .done
        nameInput.autocapitalizationType = .words
        nameInput.autocorrectionType = .no
        nameInput.becomeFirstResponder()
        nameInput.delegate = self
        
        deafPicker()
        birthdatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if name != nil {
            return nameInput.text = name
        }
    }
    
    func birthdatePicker() {
        if birthday != nil {
            birthdateInput.text = birthday
        }
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame.size = CGSize(width: 0, height: 300)
        birthdateInput.inputView = datePicker
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        birthdateInput.text = formatDate(date: datePicker.date)
        UserDefaults.standard.set(birthdateInput.text, forKey: "DATE")
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
    func deafPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        deafnessStatusInput.inputView = pickerView
    }
    
    @IBAction func saveButton() {
        nameInput.resignFirstResponder()
        
        if nameInput.text?.isEmpty == false {
            UserDefaults.standard.set(nameInput.text, forKey: "NAME")
        }
        
        self.navigationController!.popToRootViewController(animated: true)
    }
    
}

extension ChangeProfileViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        deafnessStatusInput.text = status[row]
        UserDefaults.standard.set(deafnessStatusInput.text, forKey: "DEAF")
        print(deafStatus!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text {
            print("\(text)")
        }
        
        return true
    }
}

extension ChangeProfileViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SetUpProfileViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
