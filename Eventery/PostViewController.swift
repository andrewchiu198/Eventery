//
//  PostViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

class PostViewController: UIViewController {
    
    let backgroundImage = UIImageView()
    let createLabel = UILabel()
    let createLabelBackground = UIImageView()
    let titleTextField = UITextField()
    let addressTextField = UITextField()
    let timeTextField = UITextField()
    let descriptionTextField = UITextField()
    let tagTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        backgroundImage.backgroundColor = UIColor(named: "CollectionViewBackground")
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        createLabelBackground.layer.cornerRadius = 5
        createLabelBackground.clipsToBounds = true
        createLabelBackground.backgroundColor = UIColor(named: "ButtonColor")
        createLabelBackground.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createLabelBackground)
        
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        createLabel.text = "Upload a Post!"
        createLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        createLabel.textColor = .white
        view.addSubview(createLabel)
        
        titleTextField.layer.cornerRadius = 5
        titleTextField.clipsToBounds = true
        titleTextField.textColor = .black
        titleTextField.backgroundColor = .white
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        
        addressTextField.layer.cornerRadius = 5
        addressTextField.clipsToBounds = true
        addressTextField.textColor = .black
        addressTextField.backgroundColor = .white
        addressTextField.attributedPlaceholder = NSAttributedString(
            string: "Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressTextField)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createLabelBackground.topAnchor.constraint(equalTo: createLabel.topAnchor, constant: -10),
            createLabelBackground.bottomAnchor.constraint(equalTo: createLabel.bottomAnchor, constant: 10),
            createLabelBackground.leadingAnchor.constraint(equalTo: createLabel.leadingAnchor, constant: -10),
            createLabelBackground.trailingAnchor.constraint(equalTo: createLabel.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            createLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            createLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: createLabel.bottomAnchor, constant: 25),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            titleTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            addressTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            addressTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            addressTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
    }
    
    func postEvent() {
        //blah blah check if text fields are empty here
        var eventToBePosted = Event(id: 999, title: "Sample", address: "sample", start: "sample", end: "samplke", description: "sample", host: "sample", host_email: "sample", image: "sample", free: true, attendees: [""], tags: [""])
    }
}
