//
//  LoginViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/4/23.
//

import UIKit

let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)

class LoginViewController: UIViewController {
    let titleLabel = UILabel()
    let logoImage = UIImage()
    
    let loginButton = UIButton()
    let loginLabel = UILabel()
    let signupButton = UIButton()
    let signupLabel = UILabel()
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    
    let loginButtonImage = UIImage(systemName: "person.fill.checkmark", withConfiguration: config)
    let signupButtonImage = UIImage(systemName: "person.fill.badge.plus", withConfiguration: config)
    
    var users : [User] = [User(id: 809809890, name: "", netid: "", email: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
//        loginButton.setTitle("Login", for: .normal)
//        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        loginButton.setTitleColor(carnellian, for: .normal)
        loginButton.tintColor = carnellian
        loginButton.addImage(image: loginButtonImage!, offset: 0.0)
        loginButton.backgroundColor = .systemBackground
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        
//        signupButton.setTitle("Signup", for: .normal)
        signupButton.tintColor = carnellian
        signupButton.addImage(image: signupButtonImage!, offset: 0.0)
        signupButton.backgroundColor = .systemBackground
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signupButton)
        
        loginLabel.text = "Login"
        loginLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        loginLabel.textColor = carnellian
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        nameTextField.placeholder = "Email"
        nameTextField.backgroundColor = .systemBackground
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .systemBackground
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        setupConstraints()
    }
    
    @objc func signUpButtonClicked() {
        let vc = SignUpViewController()
        present(vc, animated: true, completion: nil)
    }
    @objc func loginButtonClicked() {
        var isLoggedIn = false
        
        if let username = nameTextField.text{
            if let password = passwordTextField.text{
                print(username)
                print(password)
                
                NetworkManager.shared.postLogin(username: username, password: password){
                    error in
                    DispatchQueue.main.async {
                        isLoggedIn = true
                        //print(error)
                        NetworkManager.shared.getUser(email: username){
                            user in
                            DispatchQueue.main.async {
                                let vc = HomeViewController(user: user)
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                                print("why")
                                return
                            }
                        }
                        // isLoggedIn = true
                    }
                }
            }
        }
        nameTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        
    }
            
        
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor),
            loginLabel.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor)
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
