//
//  ShadowViewButton.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 28/06/22.
//

import Foundation
import UIKit

class ShadowViewButton {
    
    static let sharedInstance = ShadowViewButton()
    func setButtonShadow(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
    }
    
}
