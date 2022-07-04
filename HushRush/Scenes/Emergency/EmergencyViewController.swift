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

class EmergencyViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    
    var captureSession = AVCaptureSession()
    var previewLayer =  AVCaptureVideoPreviewLayer()
    var movieOutput = AVCaptureMovieFileOutput()
    var activeInput: AVCaptureDeviceInput!
    var outputURL: URL!
    
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
        
        if setupSession() {
            setupPreview()
            startSession()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(EmergencyViewController.startCapture), name: .AVCaptureSessionDidStartRunning, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let view = masterVolumeSlider.subviews.first as? UISlider{
            view.value = 1.0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        ShadowViewButton.sharedInstance.setButtonShadow(button: dismissButton)
        previewView.layer.cornerRadius = 28.0
        previewView.layer.masksToBounds = true
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = previewView.layer.bounds
        previewView.layer.addSublayer(previewLayer)
        
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
                    self?.stopRecording()
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

    
//------------RECORD VIDEO-------------------------
    func setupPreview() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = previewView.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewView.layer.addSublayer(previewLayer)
    }
    
    func setupSession() -> Bool {
        
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        let camera = AVCaptureDevice.default(for: AVMediaType.video)!
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
        
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                activeInput = input
            }
        } catch {
            print("Error setting device video input: \(error)")
            return false
        }
    
        // Movie output
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
    
        return true
    }
    func setupCaptureMode(_ mode: Int) {
        // Video Mode
    
    }

    //MARK:- Camera Session
    func startSession() {
    
        if !captureSession.isRunning {
            videoQueue().async {
                self.captureSession.startRunning()
            }
        }
    }

    func stopSession() {
        if captureSession.isRunning {
            videoQueue().async {
                self.captureSession.stopRunning()
            }
        }
    }

    func videoQueue() -> DispatchQueue {
        return DispatchQueue.main
    }

    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
    
        switch UIDevice.current.orientation {
            case .portrait:
                orientation = AVCaptureVideoOrientation.portrait
            case .landscapeRight:
                orientation = AVCaptureVideoOrientation.landscapeLeft
            case .portraitUpsideDown:
                orientation = AVCaptureVideoOrientation.portraitUpsideDown
            default:
                 orientation = AVCaptureVideoOrientation.landscapeRight
         }
    
         return orientation
     }

    @objc func startCapture() {
    
        startRecording()
    
    }

    //EDIT 1: I FORGOT THIS AT FIRST

    func tempURL() -> URL? {
        let directory = NSTemporaryDirectory() as NSString
    
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
            return URL(fileURLWithPath: path)
        }
    
        return nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    }

    func startRecording() {
    
        if movieOutput.isRecording == false {
        
            let connection = movieOutput.connection(with: AVMediaType.video)
        
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
        
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
        
            let device = activeInput.device
        
            if (device.isSmoothAutoFocusSupported) {
            
                do {
                    try device.lockForConfiguration()
                    device.isSmoothAutoFocusEnabled = false
                    device.unlockForConfiguration()
                } catch {
                   print("Error setting configuration: \(error)")
                }
            
            }
        
            //EDIT2: And I forgot this
            outputURL = tempURL()
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
        
            }
            else {
                //stopRecording()
            }
    
       }

   func stopRecording() {
    
       if movieOutput.isRecording == true {
           movieOutput.stopRecording()
        }
   }

    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
    
    }

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
    
        if (error != nil) {
        
            print("Error recording movie: \(error!.localizedDescription)")
        
        } else {
        
            UISaveVideoAtPathToSavedPhotosAlbum(outputFileURL.path, nil, nil, nil)
        
        }
    
    }
}

