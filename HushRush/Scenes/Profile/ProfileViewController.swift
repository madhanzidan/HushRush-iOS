//
//  ProfileViewController.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 12/06/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var IsDeaf: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNameDisplay()
        checkIsDeaf()
    }
    
    func checkNameDisplay() {
        if UserDefaults.standard.string(forKey: "NAME") == "" {
            return self.UserName.text = ""
        }
    }
    
    func checkIsDeaf() {
        if UserDefaults.standard.bool(forKey: "DEAF") == true {
            return self.IsDeaf.text = "Tuli/Tunarungu"
        } else {
            return self.IsDeaf.text = "Normal"
        }
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
