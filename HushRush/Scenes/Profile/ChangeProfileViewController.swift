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
    
    var updatedBirthdate: String?
    var updatedDeafnessStatus: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameInputStyling()
        birtdateReload()
    }
    
    func nameInputStyling() {
        nameInput.returnKeyType = .done
        nameInput.autocapitalizationType = .words
        nameInput.autocorrectionType = .no
        nameInput.becomeFirstResponder()
        nameInput.delegate = self
    }
    
    @IBAction func birthdayButtonTapped(_ sender: Any) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "BirthdateModal") as! BirthdateModalViewController
        controller.completionHandler = {
            text in
            self.birthdateInput.text = text
        }
        present(controller, animated: true)
    }
    
    func birtdateReload() {
        if updatedBirthdate != nil {
            birthdateInput.text = updatedBirthdate
        }
    }
    
    @IBAction func deafTapped(_ sender: UIButton) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "DeafPick") as! DeafPickViewController
        controller.completionHandler = {
            text in
            self.deafnessStatusInput.text = text
        }
        present(controller, animated: true)
    }
    
    func deafStatusReload() {
        if updatedDeafnessStatus != nil {
            deafnessStatusInput.text = updatedDeafnessStatus
        }
    }
    
    @IBAction func saveButton() {
        nameInput.resignFirstResponder()
        
        if nameInput.text?.isEmpty == false {
            UserDefaults.standard.set(nameInput.text, forKey: "NAME")
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
