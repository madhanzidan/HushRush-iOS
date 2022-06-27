//
//  CancelAlertViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 14/06/22.
//

import UIKit

class CancelAlertViewController: UIViewController {

    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var cancelTimer = Timer()
    var counter = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self]
            timer in
            print("Timer fired")
           
            countdownLabel.text = "\(counter)"
            counter -= 1

            if counter < 0 {
                self.countdownLabel.font = self.countdownLabel.font.withSize(50)
                self.countdownLabel.text = "Success"
                timer.invalidate()
                self.performSegue(withIdentifier: "goToEmergency", sender: self)
            }
        }
        
        setGradientBackground()
        setButtonShadow()
    }
    
    @IBAction func cancelAlert(_ sender: UIButton) {
        dismiss(animated: true)
        cancelTimer.invalidate()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.40).cgColor
        let colorBottom = UIColor(red: 0.90, green: 0.29, blue: 0.29, alpha: 1.00).cgColor
        
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setButtonShadow() {
        cancelButton.layer.shadowColor = UIColor.black.cgColor
        cancelButton.layer.shadowOffset = .zero
        cancelButton.layer.shadowOpacity = 0.4
        cancelButton.layer.shadowRadius = 10.0
        cancelButton.layer.masksToBounds = false
    }
}


