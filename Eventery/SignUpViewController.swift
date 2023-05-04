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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        titleButton.text = "Sign Up!"
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleButton)
        
        nameTextField.placeholder = "Username"
        nameTextField.backgroundColor = .white
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
