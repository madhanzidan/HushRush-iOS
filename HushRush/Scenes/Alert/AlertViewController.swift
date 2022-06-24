//
//  ViewController.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 12/06/22.
//

import UIKit
import Gecco

class AlertViewController: UIViewController {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var alertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func infoPressed(_ sender: UIButton) {
        showTutorial()
    }
    
    func showTutorial() {
        let spotlight = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Tutorial") as! TutorialViewController
        
        spotlight.alpha = 0.90
        present(spotlight, animated: true, completion: nil)
    }
    
    
}

