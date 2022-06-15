//
//  CancelAlertViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 14/06/22.
//

import UIKit

class CancelAlertViewController: UIViewController {

    @IBOutlet weak var CountdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var counter = 3
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
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
    }
    
    @IBAction func cancelAlert(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
//    @objc func triggerCountdown() {
//        for i in (0 ..< (3 + 1)).reversed() {
//            self.CountdownLabel.text = "\(i)"
//        }
//    }
//
//    func decrementLabel(_ startValue: Int, _ endValue: Int) {
//        let duration: Double = 2.0
//        DispatchQueue.global().async {
//            for i in (0 ..< (endValue + 1)).reversed() {
//                let sleepTime = UInt32(duration / Double(endValue) * 1000000.0)
//                usleep(sleepTime)
//                DispatchQueue.main.async {
//                    self.CountdownLabel.text = "\(i)"
//                }
//            }
//        }
//    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.40).cgColor
        let colorBottom = UIColor(red: 0.90, green: 0.29, blue: 0.29, alpha: 1.00).cgColor
        
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}


