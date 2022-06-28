//
//  SetUpFinishViewController.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 24/06/22.
//

import UIKit

class SetUpFinishViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        ShadowViewButton.sharedInstance.setButtonShadow(button: doneButton)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
