//
//  BirthdateModalViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 05/07/22.
//

import UIKit

class BirthdateModalViewController: UIViewController {
    
    private var customTransitioningDelegate = TransitioningDelegate()
    public var completionHandler: ((String) -> Void)?
    
    var birthday: String = ""
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    @IBOutlet weak var birthdatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickBirthdate()
        
        
        // Do any additional setup after loading the view.
    }
    
    func pickBirthdate() {
        birthdatePicker.addTarget(self, action: #selector(birthdateChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc func birthdateChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateToString = dateFormatter.string(from: sender.date)
        birthday = dateToString
        UserDefaults.standard.set(dateToString, forKey: "DATE")
    }
    
    @IBAction @objc func saveButton(_ sender: UIDatePicker) {
        completionHandler?(birthday)
        dismiss(animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    //}
}

private extension BirthdateModalViewController {
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
}

class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = presentingViewController.view.bounds
        let size = CGSize(width: 390, height: 300)
        let origin = CGPoint(x: bounds.midX - size.width / 2, y: bounds.midY - size.height / 2)
        return CGRect(origin: origin, size: size)
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedView?.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin,
        ]
        
        presentedView?.translatesAutoresizingMaskIntoConstraints = true
    }
}
