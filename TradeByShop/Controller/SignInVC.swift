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
    private var tapGesture = UITapGestureRecognizer()
    
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
        setupKeyBoard()
        users = realm.objects(Users.self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        
        signInButton.configuration?.attributedTitle?.font = UIFont(name: "MontserratRoman-Bold", size: CGFloat(16))

    }
    
    private func setupKeyBoard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGetstureDetected))
        tapGesture.numberOfTapsRequired = 1
    }
    
    @objc func tapGetstureDetected(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        print("keyboardWillAppear")
        view.addGestureRecognizer(tapGesture)
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= 100
                }
            }
    }

    @objc func keyboardWillDisappear() {
        print("keyboardWillDisappear")
        view.removeGestureRecognizer(tapGesture)
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
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
        
        if CheckField.shared.validField(emailView, emailTextField) {
            
            let userComplete = users.where {
                ($0.firstName == firstNameTextField.text!)
            }
            
            if !userComplete.isEmpty {
                isValidUser = false
                let alert = UIAlertController(title: "Ошибка регистрации", message: "Указанный пользователь уже существует. Пожалуйста, введите другие данные", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                print("err")
                isValidUser = true
            }
            
            isValidUser = true
        } else {
            isValidUser = false
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
            
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            emailTextField.text = ""
            
            performSegue(withIdentifier: "registeredSuccessful", sender: nil)
        }
        
    }
    
}
