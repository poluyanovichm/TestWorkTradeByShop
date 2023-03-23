//
//  ProfileVC.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var uploadItemButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageView.layer.masksToBounds = true
        
        uploadItemButton.layer.cornerRadius = 14
        uploadItemButton.layer.masksToBounds = true
        
    }
    
    @IBAction func tapLogOutButton(_ sender: UIButton) {
        
        dismiss(animated: true)
        
    }
    
    @IBAction func TapChangePhotoButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        tabBarController?.selectedIndex = 0
    }
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            userImageView.image = image
        }
        
        picker.dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
