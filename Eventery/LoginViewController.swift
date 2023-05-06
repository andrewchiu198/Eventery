//
//  LoginViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/4/23.
//

import UIKit

class LoginViewController: UIViewController {
    let logoImage = UIImageView(image: UIImage(named: "EventeryLogoTransp")!)
    
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    
    let loginButton = UIButton()
    
    let signupButton = UIButton()
    
    let padding = 15.0
    
    var users: [User] = [User(id: 809809890, name: "", netid: "", email: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "SelectedColor")
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImage)
        
        nameTextField.placeholder = "Email..."
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = .white
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password..."
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.backgroundColor = .white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        loginButton.backgroundColor = carnellian
        loginButton.setTitle(" Login ", for: .normal)
        loginButton.layer.cornerRadius = 10.0
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signupButton.backgroundColor = carnellian
        signupButton.setTitle(" Sign up? ", for: .normal)
        signupButton.layer.cornerRadius = 10.0
        signupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signupButton)
        
        setupConstraints()
    }
    
    @objc func signUpButtonClicked() {
        let vc = SignUpViewController()
        present(vc, animated: true, completion: nil)
    }

    @objc func loginButtonClicked() {
        var isLoggedIn = false
        
        if let username = nameTextField.text {
            if let password = passwordTextField.text {
                print(username)
                print(password)
                
                NetworkManager.shared.postLogin(username: username, password: password) {
                    _ in
                    DispatchQueue.main.async {
                        isLoggedIn = true
                        // print(error)
                        NetworkManager.shared.getUser(email: username) {
                            user in
                            DispatchQueue.main.async {
                                let vc = HomeViewController(user: user)
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                                print("why")
                            }
                        }
                        // isLoggedIn = true
                    }
                }
            }
        }
        nameTextField.placeholder = "Email..."
        passwordTextField.placeholder = "Password..."
    }
            
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            nameTextField.heightAnchor.constraint(equalTo: nameTextField.widthAnchor, multiplier: 0.18),
            nameTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            passwordTextField.heightAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.18)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: padding),
            loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            signupButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 2 * -padding)
        ])
    }
}
