//
//  ContactImportViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 28/06/22.
//

import UIKit
import Contacts
import ContactsUI

struct Person {
    let name: String
    let phone: String
}

class ContactImportViewController: UIViewController, CNContactPickerDelegate {
    
    @IBOutlet weak var ContactName: UITextField!
    @IBOutlet weak var ContactPhoneNumber: UITextField!
    @IBOutlet weak var saveContactButton: UIButton!
    
    var models = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let name = UserDefaults.standard.string(forKey: "contactName")
        let mobile = UserDefaults.standard.string(forKey: "contactNumber")
        
        ContactName.text = name != nil ? name : " "
        ContactPhoneNumber.text = mobile != nil ? mobile : " "
        
        ShadowViewButton.sharedInstance.setButtonShadow(button: saveContactButton)
    }
        
    @IBAction @objc func addContact(_ sender: UIButton) {
        let contactController = CNContactPickerViewController()
        contactController.delegate = self
        self.present(contactController, animated: true)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.givenName + " " + contact.familyName
        var mobile = ""
        if let phoneNumber = contact.phoneNumbers.first {
            let phoneNumberValue = phoneNumber.value
            let result = phoneNumberValue.stringValue
            self.ContactPhoneNumber.text = result
            mobile = result
        }
        
        let model = Person(name: name, phone: mobile)
        models.append(model)
        print(models)
        ContactName.text = model.name
        ContactPhoneNumber.text = model.phone
    }
    
    @IBAction func saveContact(_ sender: UIButton) {
        UserDefaults.standard.set(ContactName.text!, forKey: "contactName")
        UserDefaults.standard.set(ContactPhoneNumber.text!, forKey: "contactNumber")
        
        if ContactName.text == "" {
            print("Contact Name Empty")
        } else if ContactPhoneNumber.text == "" {
            print("Contact Number Empty")
        }
        self.navigationController!.popToRootViewController(animated: true)
    }
}
