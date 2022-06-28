//
//  SetUpEmergencyViewController.swift
//  HushRush
//
//  Created by Wilbert Devin Wijaya on 20/06/22.
//

import UIKit
import Contacts
import ContactsUI

class SetUpEmergencyViewController: UIViewController, CNContactPickerDelegate{

    @IBOutlet weak var contactsNameField: UITextField!
    @IBOutlet weak var contactsNumberField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ShadowViewButton.sharedInstance.setButtonShadow(button: saveButton)

    }
    
    @IBAction func pickMe(_ sender: Any) {
    
        let contactController = CNContactPickerViewController()
        contactController.delegate = self
        self.present(contactController, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        
        UserDefaults.standard.set(contactsNameField.text!, forKey: "contactName")
        UserDefaults.standard.set(contactsNumberField.text!, forKey: "contactNumber")
        
        if contactsNameField.text == "" {
            print("Contact Name Empty")
        } else if contactsNumberField.text == "" {
            print("Contact Number Empty")
        } else {
        performSegue(withIdentifier: "goSetUpPermission", sender: self)
        }
    }
    
    
    @IBAction func didTapSkip(_ sender: UIButton) {
        performSegue(withIdentifier: "goSetUpPermission", sender: self)
        
        if contactsNameField.text == "" {
            print("Contact Name Empty")
        } else if contactsNumberField.text == "" {
            print("Contact Number Empty")
        }
        
        UserDefaults.standard.set(contactsNameField.text!, forKey: "contactName")
        UserDefaults.standard.set(contactsNumberField.text!, forKey: "contactNumber")
        
    
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = "\(contact.givenName) \(contact.middleName) \(contact.familyName)"
        if let phoneNumber = contact.phoneNumbers.first {
            let phoneNumberValue = phoneNumber.value
            let result = phoneNumberValue.stringValue
            self.contactsNumberField.text = result
        }
        
        contactsNameField.text = name
   
    }
    
    private func retrieveContacts() {
        let contactNameField = UserDefaults.standard.string(forKey: "contactName")
        let contactNumberField = UserDefaults.standard.string(forKey: "contactNumber")
        
        //print(contactNameField)
    }

}



