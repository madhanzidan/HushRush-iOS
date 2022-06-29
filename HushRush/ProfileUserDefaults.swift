//
//  ProfileUserDefaults.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 29/06/22.
//

import Foundation
import UIKit

class ProfileUserDefaults {
    static let shared = ProfileUserDefaults()
    
    var profileImageSet: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "PROFILE_PICTURE")
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "PROFILE_PICTURE")
        }
    }
    
    var pic: NSData {
        get {
            if let userPicture = UserDefaults.standard.object(forKey: "USER_PICTURE") {
                return userPicture as! NSData
            }
            return UIImage(named: "profile")!.jpegData(compressionQuality: 0.8)! as NSData
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "USER_PICTURE")
        }
    }
}
