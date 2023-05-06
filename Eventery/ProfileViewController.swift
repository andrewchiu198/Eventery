//
//  ProfileViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class ProfileViewController: UIViewController {
    let backgroundImage = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let currentUser: User
    let profileImageView = UIImageView()
    
    init(user: User) {
        self.currentUser = user
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
//        backgroundImage.backgroundColor = UIColor(named: "CollectionViewBackground")
        view.backgroundColor = .systemBackground
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        nameLabel.text = currentUser.name
        nameLabel.textColor = .label
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height/30)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        emailLabel.text = currentUser.email
        emailLabel.textColor = .label
        emailLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height/35)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        profileImageView.image = UIImage(named: "profileImage")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        //profileImageView.addSubview(profileImageView)

        // Add buttons with delegation
        
        setupConstraints()
        
        // TODO:
        // add Delegation here because this where it makes sense
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            //image is aligned with the center axis of the view
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
