//
//  CancelAlertViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 14/06/22.
//

import UIKit

class CancelAlertViewController: UIViewController {

    @IBOutlet weak var CountdownLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    var cancelTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var counter = 3
        cancelTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {
            timer in
            print("Timer fired")
            self.CountdownLabel.text = "\(counter)"
            counter -= 1
            
            if counter < 0 {
                self.CountdownLabel.font = self.CountdownLabel.font.withSize(50)
                self.CountdownLabel.text = "Success"
                timer.invalidate()
                self.performSegue(withIdentifier: "goToEmergency", sender: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        setButtonShadow(button: cancelButton)
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
    
    func setButtonShadow(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
    }
}


