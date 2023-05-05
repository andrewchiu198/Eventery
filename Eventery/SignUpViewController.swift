//
//  SignUpViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 5/4/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let titleButton = UILabel()
    let nameTextField = UITextField()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let emailTextField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleButton.text = "Sign Up!"
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleButton)
        
        usernameTextField.placeholder = "Username"
        usernameTextField.backgroundColor = .white
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)
        
        passwordTextField.placeholder = "Username"
        passwordTextField.backgroundColor = .white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = .white
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        emailTextField.placeholder = "Name"
        emailTextField.backgroundColor = .white
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    //when sign up is clicked
    func signUpClicked(){
        if let username = usernameTextField.text{
            if let password = passwordTextField.text{
                if let name = nameTextField.text{
                    if let email = emailTextField.text{
            NetworkManager.shared.createUser(username: username, password: password, email: email, name: name){
                user in
                //let vc = HomeViewController(user: user)
                let vc = HomeViewController()
                self.present(vc, animated: true, completion: nil)
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
