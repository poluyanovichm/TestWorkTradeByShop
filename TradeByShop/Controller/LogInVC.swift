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
    private var tapGesture = UITapGestureRecognizer()
    
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var loginInButton: UIButton!
    
    @IBOutlet weak var passImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupKeyBoard()
        users = realm.objects(Users.self)
        
    }
    
    private func setup() {
        
        passImage.isHidden = true
        firstNameView.layer.cornerRadius = firstNameView.bounds.height / 2
        firstNameView.layer.masksToBounds = true
        emailView.layer.cornerRadius = firstNameView.bounds.height / 2
        emailView.layer.masksToBounds = true
        
        loginInButton.layer.cornerRadius = 14
        loginInButton.layer.masksToBounds = true
        
        firstNameTextField.textAlignment = .center
        passTextField.textAlignment = .center
        
        loginInButton.configuration?.attributedTitle?.font = UIFont(name: "MontserratRoman-Bold", size: CGFloat(16))
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
    }

    @objc func keyboardWillDisappear() {
        print("keyboardWillDisappear")
        view.removeGestureRecognizer(tapGesture)
    }
    
    @IBAction func editingDidEndFirstName(_ sender: UITextField) {
        if firstNameTextField.text == "" {
            firstNameLabel.isHidden = false
        }
    }
    
    @IBAction func editingDidBeginFirstName(_ sender: UITextField) {
        firstNameLabel.isHidden = true
    }
    
    
    @IBAction func editingDidEndPass(_ sender: UITextField) {
        if passTextField.text == "" {
            passLabel.isHidden = false
            passImage.isHidden = true
        }
    }
    
    @IBAction func editingDidBeginPass(_ sender: UITextField) {
        passLabel.isHidden = true
        passImage.isHidden = false
        
    }
    
    @IBAction func tapLogInButton(_ sender: UIButton) {
        
        var isValidUser = true
        
        if firstNameTextField.text == "" ||
            passTextField.text == "" {
            isValidUser = false
        }
        
        let userComplete = users.where {
            ($0.firstName == firstNameTextField.text!)
        }
        
        
        if !userComplete.isEmpty {
            isValidUser = true
            
        } else {
            print("err")
            
            let alert = UIAlertController(title: "Ошибка входа", message: "Пользователя с такими данными не существует", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            isValidUser = false
        }
        
        
        if isValidUser {
                        
            performSegue(withIdentifier: "loginSuccessful", sender: nil)
        }
        
    }
    
    
    @IBAction func tapShowPassButton(_ sender: UIButton) {
        
        if passTextField.isSecureTextEntry {
            passTextField.isSecureTextEntry = false
        } else {
            passTextField.isSecureTextEntry = true
        }
        
    }
    
}
