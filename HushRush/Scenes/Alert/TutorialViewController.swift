//
//  TutorialViewController.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 21/06/22.
//

import UIKit
import Gecco

class TutorialViewController: SpotlightViewController {
    
    @IBOutlet var annotationViews: [UIView]!
    
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func next(_ labelAnimated: Bool) {
        updateAnnotationView(labelAnimated)
        //let screenSize = UIScreen.main.bounds.size
        
        switch index {
        case 0:
            spotlightView.appear(Spotlight.Oval(center: CGPoint(x: 195, y: 438), diameter: 308))
        case 1:
            spotlightView.appear(Spotlight.Oval(center: CGPoint(x: 195, y: 438), diameter: 308))
        case 2:
            spotlightView.appear(Spotlight.Oval(center: CGPoint(x: 195, y: 438), diameter: 308))
        case 3:
            spotlightView.appear(Spotlight.Oval(center: CGPoint(x: 291.5, y: 785), diameter: 80))
        case 4:
            spotlightView.appear(Spotlight.Oval(center: CGPoint(x: 353, y: 65), diameter: 34))
        case 5:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
        index += 1
    }
    
    func updateAnnotationView(_ animated: Bool) {
        annotationViews.enumerated().forEach { (index, view) in
            UIView.animate(withDuration: animated ? 0.25 : 0, animations: {
                view.alpha = index == self.index ? 1 : 0
            })
        }
    }
    
    
}

extension TutorialViewController: SpotlightViewControllerDelegate {
    func spotlightViewControllerWillPresent(_ viewController: SpotlightViewController, animated: Bool) {
        next(false)
    }
    
    func spotlightViewControllerWillDismiss(_ viewController: SpotlightViewController, animated: Bool) {
        spotlightView.disappear()
    }
    
    func spotlightViewControllerTapped(_ viewController: SpotlightViewController, tappedSpotlight: SpotlightType?) {
        next(true)
    }
    
    
}
