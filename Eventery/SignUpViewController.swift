//
//  SignUpViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/4/23.
//

import UIKit

class SignUpViewController: UIViewController {
    let logoImage = UIImageView(image: UIImage(named: "eventerylogotransp")!)
    let signupLabel = UILabel()
    let signupButton = UIButton()
    let nameTextField = UITextField()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let emailTextField = UITextField()
    let padding = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "HighlightColor")
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImage)
        
        signupLabel.text = "Create your Eventery account:"
        signupLabel.textColor = carnellian
        signupLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.width / 12)
        signupLabel.numberOfLines = 0
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signupLabel)
        
        nameTextField.placeholder = "Name..."
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.autocapitalizationType = .none
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = .white
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        emailTextField.placeholder = "Email..."
        emailTextField.layer.cornerRadius = 10.0
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = .white
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        usernameTextField.placeholder = "Username..."
        usernameTextField.layer.cornerRadius = 10.0
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        usernameTextField.backgroundColor = .white
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)
        
        passwordTextField.placeholder = "Password..."
        passwordTextField.layer.cornerRadius = 10.0
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.backgroundColor = .white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        signupButton.backgroundColor = carnellian
        signupButton.setTitle(" Sign up! ", for: .normal)
        signupButton.layer.cornerRadius = 10.0
        signupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        view.addSubview(signupButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signupLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor),
            signupLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            signupLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2 * padding)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            nameTextField.heightAnchor.constraint(equalTo: nameTextField.widthAnchor, multiplier: 0.18),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: padding),
            emailTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            emailTextField.heightAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 0.18)
        ])
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: padding),
            usernameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            usernameTextField.heightAnchor.constraint(equalTo: usernameTextField.widthAnchor, multiplier: 0.18)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: padding),
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            passwordTextField.heightAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.18)
        ])
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1.5 * padding),
            signupButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    // when sign up is clicked
    @objc func signUpClicked() {
        if let username = usernameTextField.text {
            if let password = passwordTextField.text {
                if let name = nameTextField.text {
                    if let email = emailTextField.text {
                        NetworkManager.shared.createUser(username: username, password: password, email: email, name: name) {
                            response in
                            DispatchQueue.main.async {
                                let user = User(id: response.id, name: response.name, netid: response.netid, email: response.email)
                                let vc = HomeViewController(user: user)
                                vc.modalPresentationStyle = .fullScreen
                                self.present(vc, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
