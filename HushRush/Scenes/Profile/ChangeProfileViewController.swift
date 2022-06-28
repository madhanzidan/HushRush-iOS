//
//  ChangeProfileViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 28/06/22.
//

import UIKit

class ChangeProfileViewController: UIViewController {
    @IBOutlet weak var InputName: UITextField!
    @IBOutlet weak var InputDate: UIDatePicker!
    @IBOutlet weak var InputDeafnessStatus: UIButton!
    
    var name: String? = UserDefaults.standard.string(forKey: "NAME")
    var birthday: String? = UserDefaults.standard.string(forKey: "DATE")
    var isDeaf: Bool? = UserDefaults.standard.bool(forKey: "DEAF")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopupButton()
        
        InputName.returnKeyType = .done
        InputName.autocapitalizationType = .words
        InputName.autocorrectionType = .no
        InputName.becomeFirstResponder()
        InputName.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if name != nil {
            return InputName.text = name
        }
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        UserDefaults.standard.set(formatter.string(from: sender.date), forKey: "DATE")
    }
    
    func setPopupButton() {
        let optionClosure = {(action: UIAction) in
            print(action.title)
            if action.title == "Ya" {
                UserDefaults.standard.set(true, forKey: "DEAF")
            } else {
                UserDefaults.standard.set(false, forKey: "DEAF")
            }
        }
        
        InputDeafnessStatus.menu = UIMenu(children: [
            UIAction(title: "Ya", state: .on, handler: optionClosure),
            UIAction(title: "Tidak", handler: optionClosure)
        ])
        
        InputDeafnessStatus.showsMenuAsPrimaryAction = true
        InputDeafnessStatus.changesSelectionAsPrimaryAction = true
    }
    
    @IBAction func saveButton() {
        InputName.resignFirstResponder()
        
        if InputName.text?.isEmpty == false {
            UserDefaults.standard.set(InputName.text, forKey: "NAME")
        }
        
        self.navigationController!.popToRootViewController(animated: true)
    }
    
}

extension ChangeProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text {
            print("\(text)")
        }
        
        return true
    }
}
