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
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let descriptionTextView = UITextView()
    let postButton = UIButton()
    var interestsCollectionView: UICollectionView!
    let interestsReuseID = "interestsReuseID"

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
        
        let interestsFlowLayout = UICollectionViewFlowLayout()
        interestsFlowLayout.minimumLineSpacing = 5
        interestsFlowLayout.minimumInteritemSpacing = 5
        interestsFlowLayout.scrollDirection = .horizontal
        interestsFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        interestsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: interestsFlowLayout)
        interestsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        interestsCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: interestsReuseID)
        interestsCollectionView.dataSource = self
        interestsCollectionView.delegate = self
        interestsCollectionView.backgroundColor = UIColor(named: "CollectionViewBackground")
        interestsCollectionView.tag = 0
        interestsCollectionView.clipsToBounds = true
        interestsCollectionView.flashScrollIndicators()
        view.addSubview(interestsCollectionView)
        
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
        
        startTimeTextField.layer.cornerRadius = 5
        startTimeTextField.clipsToBounds = true
        startTimeTextField.textColor = .black
        startTimeTextField.backgroundColor = .white
        startTimeTextField.attributedPlaceholder = NSAttributedString(
            string: "Start Time: ",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        startTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startTimeTextField)
        
        endTimeTextField.layer.cornerRadius = 5
        endTimeTextField.clipsToBounds = true
        endTimeTextField.textColor = .black
        endTimeTextField.backgroundColor = .white
        endTimeTextField.attributedPlaceholder = NSAttributedString(
            string: "End Time:",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
            )
        endTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(endTimeTextField)
        
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
        postButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
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
            startTimeTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            startTimeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            startTimeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            startTimeTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            endTimeTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            endTimeTextField.leadingAnchor.constraint(equalTo: startTimeTextField.trailingAnchor, constant: 10),
            endTimeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            endTimeTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        
        NSLayoutConstraint.activate([
            interestsCollectionView.topAnchor.constraint(equalTo: endTimeTextField.bottomAnchor, constant: 10),
            interestsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            interestsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            interestsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: interestsCollectionView.bottomAnchor, constant: 10),
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
        var eventToBePosted = Event(id: 99, title: "", address: "", start: "", end: "", user: "", userEmail: "", description: "", free: false, category: "")
    }
}

extension PostViewController: UICollectionViewDelegate {
    
    
    
}

extension PostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.categories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestsReuseID, for: indexPath) as? CategoriesCollectionViewCell {
            cell.configureCell(category: Categories.categories[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension PostViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.5, height: view.frame.height/27)
    }
}

extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
