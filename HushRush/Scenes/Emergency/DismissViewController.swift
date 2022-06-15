//
//  DismissViewController.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 12/06/22.
//

import UIKit

class DismissViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var counter = 3
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            counter -= 1
            if counter < 0 {
                timer.invalidate()
                self.performSegue(withIdentifier: "goToTabBar", sender: self)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
    }
    
    //MARK: - Function to modify view
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.40).cgColor
        let colorBottom = UIColor(red: 0.22, green: 0.47, blue: 1.00, alpha: 1.00).cgColor
        
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

}
