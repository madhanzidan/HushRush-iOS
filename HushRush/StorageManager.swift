//
//  StorageManager.swift
//  HushRush
//
//  Created by Wilbert Devin Wijaya on 28/06/22.
//

import UIKit

class StoragManager {
    
    enum Key: String {
        case onboardingSeen
        
    }
    
    func isOnboardingSeen() -> Bool {
        
        UserDefaults.standard.bool(forKey: Key.onboardingSeen.rawValue)
        
    }
    
    func setOnboardingSeen() {
        
        UserDefaults.standard.set(true, forKey: Key.onboardingSeen.rawValue)
        
    }
    
    func resetOnboardingSeen() {
        
        UserDefaults.standard.set(true, forKey: Key.onboardingSeen.rawValue)
        
    }
    
}
