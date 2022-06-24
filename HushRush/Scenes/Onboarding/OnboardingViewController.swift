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
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        slides = [
            OnboardingSlide(title: "Selamat datang di HushRush!", description: "Aplikasi pendamping pribadi anda ketika anda berada di kondisi darurat, dibuat khusus untuk penyandang tuli.", image: #imageLiteral(resourceName: "firstOnboarding")),
            OnboardingSlide(title: "Penyelamat Instan untuk Anda", description: "Hanya dengan satu sentuhan tombol, HushRush akan membunyikan alarm keras, merekam video sebagai bukti, dan mengirimkan lokasi anda ke kontak darurat.", image: #imageLiteral(resourceName: "secondOnboarding")),
            OnboardingSlide(title: "Sistem Keamanan Anti-tipu", description: "Kami menggunakan PIN untuk menonaktifkan alarm untuk memastikan bahwa itu benar-benar anda.", image: #imageLiteral(resourceName: "thirdOnboarding"))
        
        ]

    }
    @IBAction func didTapNext(_ sender: UIButton) {
        performSegue(withIdentifier: "goSetUpProfile", sender: self)
    }
    
    @IBAction func dalamBahayaPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTabBar", sender: self)
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
    
}
