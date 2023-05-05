//
//  LoginViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/4/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginButton = UIButton()
    let signupButton = UIButton()
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    
    var users : [User] = [User(username: "", password: "", email: "", name: "")]


    override func viewDidLoad() {
        super.viewDidLoad()
                
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(named: "ButtonColor")
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signupButton.setTitle("Signup", for: .normal)
        signupButton.backgroundColor = UIColor(named: "ButtonColor")
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signupButton)
        
        nameTextField.placeholder = "Username"
        nameTextField.backgroundColor = .white
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        

        setupConstraints()
        
    }
    
    @objc func signUpButtonClicked() {
        let vc = SignUpViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func loginButtonClicked() {
        
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
