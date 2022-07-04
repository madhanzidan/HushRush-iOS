//
//  ProfileViewController.swift
//  HushRush
//
//  Created by Zidan Ramadhan on 12/06/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var IsDeaf: UILabel!
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    var pic: NSData? = nil
    var picSet = false
    var image: UIImage = UIImage(named: "profile")!
    var imageSet: UIImage = UIImage(data: ProfileUserDefaults.shared.pic as Data)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfilePicture.image = ProfileUserDefaults.shared.profileImageSet ? UIImage(data: ProfileUserDefaults.shared.pic as Data) : image
        pic = image.jpegData(compressionQuality: 0.5)! as NSData
        ProfilePicture.image = imageSet
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        ProfilePicture.layer.cornerRadius = self.ProfilePicture.frame.height / 2
        ProfilePicture.layer.borderWidth = 4
        ProfilePicture.layer.borderColor = UIColor.white.cgColor
        
        let name = UserDefaults.standard.string(forKey: "NAME")
        let isDeaf = UserDefaults.standard.bool(forKey: "DEAF")
        
        UserName.text = name != nil ? name : "--"
        IsDeaf.text = isDeaf == true ? "Tuli/Tunarungu" : "--"
        
        //MARK: - Shadow for button and background
        ShadowViewButton.sharedInstance.setButtonShadow(button: profileButton)
        ShadowViewButton.sharedInstance.setButtonShadow(button: contactButton)
        setGradientBackground()
        
        
    }
        
    @IBAction func profilePictureTapped() {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        present(viewController, animated: true)
        self.picSet = true
    }
        
    @IBAction func emergencyContactTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "AddContact", sender: self)
    }
    
    //MARK: - Function to modify view
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.40).cgColor
        let colorBottom = UIColor(red: 0.90, green: 0.29, blue: 0.29, alpha: 1.00).cgColor
        
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.4]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            ProfilePicture.image = image
            pic = image.jpegData(compressionQuality: 0.5)! as NSData
            ProfileUserDefaults.shared.pic = pic!
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
