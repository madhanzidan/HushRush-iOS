//
//  NavigationManager.swift
//  HushRush
//
//  Created by Wilbert Devin Wijaya on 28/06/22.
//

import UIKit

class NavigationManager {
    
    enum Screen {
        case onboarding
        case mainApp
    }
    
    func show(screen: Screen, inController: UIViewController) {
        
        var viewController: UIViewController!
        
        switch screen {
        case .onboarding:
            
            viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController")
            
        case .mainApp:
            
            viewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController")
        }

        if let sceneDelegate = inController.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
        
    }
    
}
