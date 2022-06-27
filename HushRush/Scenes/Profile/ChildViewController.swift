//
//  ChildViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 24/06/22.
//

import UIKit

class ChildViewController: UIViewController {
    @IBOutlet var StackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func updateViewConstraints() {
        let TOP_CARD_DISTANCE: CGFloat = 40.0
        var height: CGFloat = 0.0
        for x in self.StackView.subviews {
            height = height + x.frame.size.height
        }
        
        self.view.frame.size.height = height
        self.view.frame.origin.y = UIScreen.main.bounds.height - height - TOP_CARD_DISTANCE
        self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        super.updateViewConstraints()
        
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
