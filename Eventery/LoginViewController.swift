//
//  LoginViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/4/23.
//

import UIKit

let buttonConfig = UIImage.SymbolConfiguration(scale: .large)

let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)

class LoginViewController: UIViewController {
    let loginButton = UIButton()
    let signupButton = UIButton()
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    
    let loginButtonImage = UIImage(systemName: "person.fill.checkmark", withConfiguration: config) // ?.withConfiguration(buttonConfig)
    
    var users : [User] = [User(id: 809809890, name: "", netid: "", email: "")]

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.titleLabel?.text = "Login"
        loginButton.tintColor = carnellian
        loginButton.titleLabel?.textColor = carnellian
        loginButton.imageView?.image = UIImage(named: "person.fill.checkmark")
        loginButton.addImage(image: loginButtonImage!, offset: 0.0)
        loginButton.imageView?.tintColor = carnellian
        loginButton.tintColor = carnellian
        loginButton.backgroundColor = .secondarySystemBackground
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signupButton.setTitle("Signup", for: .normal)
        signupButton.backgroundColor = UIColor(named: "ButtonColor")
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        view.addSubview(signupButton)
        
        nameTextField.placeholder = "Email"
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
