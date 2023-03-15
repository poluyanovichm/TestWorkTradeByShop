//
//  SignInVC.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit
import RealmSwift

class SignInVC: UIViewController {
    
    let realm = try! Realm()
    var users: Results<Users>!
    
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        users = realm.objects(Users.self)


    }
    
    private func setup() {
        
        firstNameView.layer.cornerRadius = firstNameView.bounds.height / 2
        firstNameView.layer.masksToBounds = true
        lastNameView.layer.cornerRadius = firstNameView.bounds.height / 2
        lastNameView.layer.masksToBounds = true
        emailView.layer.cornerRadius = firstNameView.bounds.height / 2
        emailView.layer.masksToBounds = true
        
        signInButton.layer.cornerRadius = 14
        signInButton.layer.masksToBounds = true
        
        firstNameTextField.textAlignment = .center
        lastNameTextField.textAlignment = .center
        emailTextField.textAlignment = .center

    }
    
    @IBAction func editingDidEndFirstName(_ sender: UITextField) {
        if firstNameTextField.text == "" {
            firstNameLabel.isHidden = false
        }
    }
    
    @IBAction func editingDidBeginFirstName(_ sender: UITextField) {
        firstNameLabel.isHidden = true
    }
    
    @IBAction func editingDidEndLastName(_ sender: UITextField) {
        if lastNameTextField.text == "" {
            lastNameLabel.isHidden = false
        }
    }
    
    @IBAction func editingDidBeginLastName(_ sender: UITextField) {
        lastNameLabel.isHidden = true
    }

    
    @IBAction func editingDidEndEmail(_ sender: UITextField) {
        if emailTextField.text == "" {
            emailLabel.isHidden = false
        }
    }
    
    @IBAction func editingDidBeginEmail(_ sender: UITextField) {
        emailLabel.isHidden = true

    }
    
    @IBAction func tapSignInButton(_ sender: UIButton) {
        
        var isValidUser = true
        
        if firstNameTextField.text == "" ||
            lastNameTextField.text == "" ||
            emailTextField.text == "" {
            isValidUser = false
        }
        
        let userComplete = users.where {
            ($0.firstName == firstNameTextField.text!)
        }
        
        if !userComplete.isEmpty {
            print("не пустой")
            isValidUser = false
            let alert = UIAlertController(title: "Ошибка регистрации", message: "Указанный email уже существует. Пожалуйста, введите новый email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            print("err")
            isValidUser = true
        }
        
        
        if isValidUser {
            
            let realmObject = Users()
            realmObject.firstName = firstNameTextField.text!
            realmObject.lastName = lastNameTextField.text!
            realmObject.password = "123"
            realmObject.email = emailTextField.text!
            
            try! realm.write {
                realm.add(realmObject)
            }
            
            performSegue(withIdentifier: "registeredSuccessful", sender: nil)
        }
        
    }
    
}
