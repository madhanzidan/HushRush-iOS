//
//  EmergencyViewController.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 12/06/22.
//

import UIKit
import MediaPlayer
import AudioToolbox
import LocalAuthentication
import AVFoundation

class EmergencyViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    let masterVolumeSlider: MPVolumeView = MPVolumeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmergencySingleton.sharedInstance.playSound()
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch {
            print(error)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let view = masterVolumeSlider.subviews.first as? UISlider{
            view.value = 1.0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        setButtonShadow(button: dismissButton)
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Enter passcode to stop the alert"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        //failed
                        let alert = UIAlertController(title: "Try Again", message: "Enter passcode to stop the alert", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                        self?.present(alert, animated: true)
                        return
                    }
                    //show other screen & success
                    EmergencySingleton.sharedInstance.stopSound()
                    self?.performSegue(withIdentifier: "goToDismiss", sender: self)
                }
            }
        } else {
            //cannot use
            let alert = UIAlertController(title: "Try Again", message: "Enter passcode to stop the alert", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
    
    //MARK: - Function to modify view
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

