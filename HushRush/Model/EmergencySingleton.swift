//
//  EmergencySingleton.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 12/06/22.
//

import Foundation

import AVFoundation
import AudioToolbox.AudioServices


class EmergencySingleton {
    var player: AVAudioPlayer?
    var vibrationTimer = Timer()
    var startTorchTimer = Timer()
    var stopTorchTimer = Timer()

    static let sharedInstance = EmergencySingleton()
  
    func playSound() {
        guard let url = Bundle.main.url(forResource: "siren_final", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.numberOfLoops = -1
            player.play()
            
            vibrationTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(startVibration), userInfo: nil, repeats: true)
            startTorchTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(startTorch), userInfo: nil, repeats: true)
            stopTorchTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(stopTorch), userInfo: nil, repeats: true)
            

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        vibrationTimer.invalidate()
        startTorchTimer.invalidate()
        stopTorchTimer.invalidate()
        stopTorch()
        player?.stop()
    }
    
    
    @objc func startVibration() {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    @objc func startTorch() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = .on
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    @objc func stopTorch() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                device.torchMode = .off
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    
}
