//
//  DeafPickViewController.swift
//  HushRush
//
//  Created by Sherary Apriliana on 05/07/22.
//

import UIKit

class DeafPickViewController: UIViewController {
    private var customTransitioningDelegate = TransitioningDelegate()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    @IBOutlet var deafPicker: UIPickerView!
    let status = [" ", "Tuli", "Tunarungu"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deafPickerDelegates()
    }
    
    func deafPickerDelegates() {
        deafPicker.delegate = self
        deafPicker.dataSource = self
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    public var completionHandler: ((String) -> Void)?
    @IBAction @objc func saveButton(_ sender: UIPickerView) {
        completionHandler?(UserDefaults.standard.string(forKey: "DEAF")!)
        dismiss(animated: true)
    }
}

private extension DeafPickViewController {
    func configure() {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        transitioningDelegate = customTransitioningDelegate
    }
}

extension DeafPickViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return status.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return status[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(status[row], forKey: "DEAF")
    }
}
