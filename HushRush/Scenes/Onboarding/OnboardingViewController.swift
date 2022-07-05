//
//  OnboardingViewController.swift
//  HushRush
//
//  Created by Wilbert Devin Wijaya on 21/06/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var haveTimeButton: UIButton!
    @IBOutlet weak var inDangerButton: UIButton!
    
    let onBoarding = OnboardingSlide()
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0
    
    private let storageManager = StoragManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateFlag()
        slides = onBoarding.populateOnBoardingData()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        ShadowViewButton.sharedInstance.setButtonShadow(button: haveTimeButton)
        ShadowViewButton.sharedInstance.setButtonShadow(button: inDangerButton)

    }
    
    
    @IBAction func didTapNext(_ sender: UIButton) {
        performSegue(withIdentifier: "goSetUpProfile", sender: self)
    }
    
    @IBAction func dalamBahayaPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTabBar", sender: self)
    }
    
    func updateFlag() {
        storageManager.setOnboardingSeen()
    }
    
    private func showMainApp() {
        let mainAppViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = mainAppViewController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
        
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
    
    func didTapExploreButton() {
        showMainApp()
    }
    
}
