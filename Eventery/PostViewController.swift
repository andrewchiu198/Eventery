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
    let titleTextField = UITextField()
    let addressTextField = UITextField()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let descriptionTextView = UITextView()
    let postButton = UIButton()
    let freeButton = UIButton()
    var categoriesCollectionView: UICollectionView!
    let categoriesReuseID = "categoriesReuseID"
    let datePicker = UIDatePicker()
    var selectedCategory: String?
    let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust the text fields

        view.backgroundColor = UIColor(named: "BackgroundColor")
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
        backgroundImage.backgroundColor = UIColor(named: "CollectionViewBackground")
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        let categoriesFlowLayout = UICollectionViewFlowLayout()
        categoriesFlowLayout.minimumLineSpacing = 5
        categoriesFlowLayout.minimumInteritemSpacing = 5
        categoriesFlowLayout.scrollDirection = .horizontal
        categoriesFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        freeButton.backgroundColor = .gray
        freeButton.translatesAutoresizingMaskIntoConstraints = false
        freeButton.setTitle("Free", for: .normal)
        view.addSubview(freeButton)
        
        
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoriesFlowLayout)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: categoriesReuseID)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = UIColor(named: "CollectionViewBackground")
        categoriesCollectionView.clipsToBounds = true
        categoriesCollectionView.flashScrollIndicators()
        categoriesCollectionView.allowsMultipleSelection = false
        view.addSubview(categoriesCollectionView)
        
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        createLabel.text = "Upload a Post!"
        createLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        createLabel.textColor = .label
        view.addSubview(createLabel)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = ""
        errorLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.017)
        errorLabel.textColor = .red
        view.addSubview(errorLabel)
        
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
        endTimeTextField.inputView = datePicker
        endTimeTextField.inputAccessoryView = createToolBar()
        view.addSubview(endTimeTextField)
        
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        descriptionTextView.textColor = .gray
        descriptionTextView.isEditable = true
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
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        startTimeTextField.inputView = datePicker
        startTimeTextField.inputAccessoryView = createToolBar()
        
        setupConstraints()
        
    }
    
    func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
    
    @objc func donePressed() {
        print(datePicker.date)
        
        let formattedDate = ""
        
        self.startTimeTextField.text = "\(datePicker.date)"
        self.view.endEditing(true)
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
            createLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            createLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: createLabel.bottomAnchor, constant: 5),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
            freeButton.topAnchor.constraint(equalTo: startTimeTextField.bottomAnchor, constant: 10),
            freeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            freeButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            freeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: freeButton.bottomAnchor, constant: 10),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            categoriesCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 10),
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
        
        var lastID = 0
        
        NetworkManager.shared.getAllEvents {
            events in DispatchQueue.main.async {
                lastID = events[events.count - 1].id
            }
        }
        
        if let titleText = titleTextField.text {
            if let addressText = addressTextField.text {
                if let descriptionText = descriptionTextView.text {
                    if let chosenCategory = selectedCategory {
                        NetworkManager.shared.createEvent(id: lastID, title: titleText, address: addressText, start: "2023-05-03T14:00:00", end: "2023-05-03T14:00:00", user: "udp3", userEmail: "udp3@cornell.edu", description: descriptionText, free: true, category: chosenCategory) {
                            event in
                        }
                        errorLabel.text = ""
                        return
                    }
                }
            }
        }
        
        errorLabel.text = "No Upload, Invalid Formatting"
        
        
        
        //var eventToBePosted = Event(id: 99, title: "", address: "", start: "", end: "", description: "", host: "", host_email: "", free: false, category: "")
    }
}

extension PostViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell: CategoriesCollectionViewCell = categoriesCollectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        
        selectedCategory = cell.category
        for row in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = NSIndexPath(row: row, section: 0)
            
            let cell: UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath) ?? cell
            cell.contentView.backgroundColor = UIColor(named: "ButtonColor")
        }
        cell.contentView.backgroundColor = .black
        
        
    }
}

extension PostViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.categories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoriesReuseID, for: indexPath) as? CategoriesCollectionViewCell {
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
