//
//  OnboardingSlide.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 24/06/22.
//

import UIKit

struct OnboardingSlide {
    var title: String?
    var description: String?
    var image: UIImage?
    
    func populateOnBoardingData() -> [OnboardingSlide] {
        let slides = [
            OnboardingSlide(title: "Selamat datang di HushRush!", description: "HushRush adalah kata yang diambil dari Bahasa Inggris. Hush yang artinya sunyi, dan rush yang artinya bergegas.", image: #imageLiteral(resourceName: "IconView")),
            OnboardingSlide(title: "Pendamping Anda dalam darurat", description: "Aplikasi pendamping pribadi anda ketika anda berada di kondisi darurat, dibuat khusus untuk penyandang tuli.", image: #imageLiteral(resourceName: "firstOnboarding")),
            OnboardingSlide(title: "Penyelamat Instan untuk Anda", description: "Hanya dengan satu sentuhan tombol, HushRush akan membunyikan alarm keras, merekam video sebagai bukti, dan mengirimkan lokasi anda ke kontak darurat.", image: #imageLiteral(resourceName: "secondOnboarding")),
            OnboardingSlide(title: "Sistem Keamanan Anti-tipu", description: "Kami menggunakan PIN untuk menonaktifkan alarm untuk memastikan bahwa itu benar-benar anda.", image: #imageLiteral(resourceName: "thirdOnboarding"))
        
        ]
        return slides
    }
}
