//
//  SetUpPermissionViewController.swift
//  HushRush
//
//  Created by Wilbert Devin Wijaya on 21/06/22.
//

import UIKit
import AVFoundation
import Photos
import CoreLocation

class SetUpPermissionViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var descriptionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    @IBAction func didTapNext(_ sender: Any) {
        cameraPermission()
        microphonePermission()
        locationPermission()

        performSegue(withIdentifier: "goSetUpFinish", sender: self)
 
        
    }
    @IBAction func didTapDesc(_ sender: Any) {
        performSegue(withIdentifier: "goDescription", sender: self )
    }
    @IBAction func didTapCloseDesc(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func cameraPermission() {
        
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) {
            response in
            if response {
                
            } else {
                
            }
        }
        
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    
                } else {
                    
                }
            })
        }
    }
    
    func microphonePermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            print("Permission Granted")
           
        
        case .denied:
            print("Permission Denied")
            
        case .undetermined:
            print("Request Permission Here")
            AVAudioSession.sharedInstance().requestRecordPermission ({ granted in
                
            })
        
        @unknown default:
            print("Unknown Case")
        }
    }
    
    func locationPermission() {
        LocationManager.shared.requestLocationAuthorization()
    }

    func setButtonShadow(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
    }

}

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?

    public func requestLocationAuthorization() {
        self.locationManager.delegate = self
        let currentStatus = CLLocationManager.authorizationStatus()

        // Only ask authorization if it was never asked before
        guard currentStatus == .notDetermined else { return }

        // Starting on iOS 13.4.0, to get .authorizedAlways permission, you need to
        // first ask for WhenInUse permission, then ask for Always permission to
        // get to a second system alert
        if #available(iOS 13.4, *) {
            self.requestLocationAuthorizationCallback = { status in
                if status == .authorizedWhenInUse {
                    self.locationManager.requestAlwaysAuthorization()
                }
            }
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    // MARK: - CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        self.requestLocationAuthorizationCallback?(status)
    }
}
