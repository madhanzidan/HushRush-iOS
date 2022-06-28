//
//  LoadingViewController.swift
//  HushRush
//
//  Created by Wilbert Devin Wijaya on 28/06/22.
//

import UIKit

class LoadingViewController: UIViewController {
    
    private var isOnboardingSeen: Bool!
    
    private let navigationManager = NavigationManager()
    private let storageManager = StoragManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnboardingSeen = storageManager.isOnboardingSeen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInitialScreen()
    }
    
    func showInitialScreen() {
        
        if isOnboardingSeen {
            
            navigationManager.show(screen: .mainApp, inController: self)
            
        } else {
            
            navigationManager.show(screen: .onboarding, inController: self)
        }
    }

    
}
