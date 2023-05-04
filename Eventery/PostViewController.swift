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
    let descriptionTextView = UITextView()
    let tagTextField = UITextField()
    let postButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust the text fields

        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
        
        timeTextField.layer.cornerRadius = 5
        timeTextField.clipsToBounds = true
        timeTextField.textColor = .black
        timeTextField.backgroundColor = .white
        timeTextField.attributedPlaceholder = NSAttributedString(
            string: "00/00/0000 0:00p.m.",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeTextField)
        
        tagTextField.layer.cornerRadius = 5
        tagTextField.clipsToBounds = true
        tagTextField.textColor = .black
        tagTextField.backgroundColor = .white
        tagTextField.attributedPlaceholder = NSAttributedString(
            string: "Tag",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        tagTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagTextField)
        
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        descriptionTextView.textColor = .gray
        descriptionTextView.backgroundColor = .white
        descriptionTextView.font = UIFont(name: "Helvetica", size: view.frame.height * 0.02)
        descriptionTextView.text = "Enter Description Here..."
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        
        postButton.clipsToBounds = true
        postButton.backgroundColor = UIColor(named: "ButtonColor")
        postButton.setTitleColor(.white, for: .normal)
        postButton.setTitle("Post Event!", for: .normal)
        //postButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        postButton.layer.cornerRadius = 5
        postButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        postButton.addTarget(self, action: #selector(postEvent), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postButton)

        
        
        setupConstraints()
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        
        NSLayoutConstraint.activate([
            timeTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            timeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            timeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            timeTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            tagTextField.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 10),
            tagTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tagTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            tagTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: tagTextField.bottomAnchor, constant: 10),
            descriptionTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor,constant: 15),
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func postEvent() {
        //blah blah check if text fields are empty here
        NetworkManager.shared.createEvent(id: nil, title: titleTextField.text!, address: addressTextField.text!, start: "0000-00-00T00:00:00", end: "0000-00-00T00:00:00", user: "udp3", userEmail: "udp3@cornell.edu", description: descriptionTextView.text!, free: true, category: "Sports"){
            event in
            print("Success posting!")
            
        }
        //var eventToBePosted = Event(id: 99, title: "", address: "", start: "", end: "", description: "", host: "", host_email: "", free: false, category: "")
    }
}
