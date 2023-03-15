//
//  LogInVC.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit
import RealmSwift

class LogInVC: UIViewController {
    
    let realm = try! Realm()
    var users: Results<Users>!
    
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var loginInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        users = realm.objects(Users.self)
        
    }
    
    private func setup() {
        
        firstNameView.layer.cornerRadius = firstNameView.bounds.height / 2
        firstNameView.layer.masksToBounds = true
        emailView.layer.cornerRadius = firstNameView.bounds.height / 2
        emailView.layer.masksToBounds = true
        
        loginInButton.layer.cornerRadius = 14
        loginInButton.layer.masksToBounds = true
        
        firstNameTextField.textAlignment = .center
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
    
    
    @IBAction func editingDidEndEmail(_ sender: UITextField) {
        if emailTextField.text == "" {
            emailLabel.isHidden = false
        }
    }
    
    @IBAction func editingDidBeginEmail(_ sender: UITextField) {
        emailLabel.isHidden = true
        
    }
    
    @IBAction func tapLogInButton(_ sender: UIButton) {
        
        var isValidUser = true
        
        if firstNameTextField.text == "" ||
            emailTextField.text == "" {
            isValidUser = false
        }
        
        let userComplete = users.where {
            ($0.firstName == firstNameTextField.text!) && ($0.email == emailTextField.text!)
        }
        
        
        if !userComplete.isEmpty {
            print("не пустой")
            isValidUser = true
            
        } else {
            print("err")
            
            let alert = UIAlertController(title: "Ошибка входа", message: "Пользователя с такими данными не существует", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            isValidUser = false
        }
        
        
        if isValidUser {
            
            print("переход")
            
            performSegue(withIdentifier: "loginSuccessful", sender: nil)
        }
        
    }
    
}
