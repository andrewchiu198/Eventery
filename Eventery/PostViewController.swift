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
    var descriptionTextView = UITextView()
    let postButton = UIButton()
    let freeButton = UIButton()
    var categoriesCollectionView: UICollectionView!
    let categoriesReuseID = "categoriesReuseID"
    let datePicker = UIDatePicker()
    var selectedCategory: String?
    let errorLabel = UILabel()
    let endButton = UIButton()
    
    var user: User = User(id: 9089809, name: "udp3", netid: "udp3@cornell.edu", email: "Deepa Pulugurtha")

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adjust the text fields

        view.backgroundColor = .systemBackground
        
        backgroundImage.backgroundColor = .systemBackground
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImage)
        
        let categoriesFlowLayout = UICollectionViewFlowLayout()
        categoriesFlowLayout.minimumLineSpacing = 5
        categoriesFlowLayout.minimumInteritemSpacing = 5
        categoriesFlowLayout.scrollDirection = .horizontal
        categoriesFlowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        freeButton.backgroundColor = carnellian
        freeButton.translatesAutoresizingMaskIntoConstraints = false
        freeButton.setTitle("Free", for: .normal)
        freeButton.isSelected = false
        freeButton.layer.cornerRadius = 5
        freeButton.clipsToBounds = true
        freeButton.addTarget(self, action: #selector(freeButtonClicked), for: .touchUpInside)
        freeButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        view.addSubview(freeButton)
        
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoriesFlowLayout)
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: categoriesReuseID)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = .secondaryLabel
        categoriesCollectionView.clipsToBounds = true
        categoriesCollectionView.flashScrollIndicators()
        categoriesCollectionView.allowsMultipleSelection = false
        categoriesCollectionView.backgroundColor = .secondarySystemBackground
        view.addSubview(categoriesCollectionView)
        
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        createLabel.text = "Upload a Post!"
        createLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        createLabel.textColor = .label
        view.addSubview(createLabel)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = ""
        errorLabel.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.017)
        errorLabel.textColor = carnellian
        view.addSubview(errorLabel)
        
        titleTextField.delegate = self
        titleTextField.layer.cornerRadius = 5
        titleTextField.clipsToBounds = true
        titleTextField.textColor = .label
        titleTextField.backgroundColor = .secondarySystemBackground
        titleTextField.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        
        addressTextField.delegate = self
        addressTextField.layer.cornerRadius = 5
        addressTextField.clipsToBounds = true
        addressTextField.textColor = .label
        addressTextField.backgroundColor = .secondarySystemBackground
        addressTextField.attributedPlaceholder = NSAttributedString(
            string: "Address",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
        )
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressTextField)
        
        startTimeTextField.layer.cornerRadius = 5
        startTimeTextField.clipsToBounds = true
        startTimeTextField.textColor = .label
        startTimeTextField.backgroundColor = .secondarySystemBackground
        startTimeTextField.attributedPlaceholder = NSAttributedString(
            string: "Start Time: ",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
            )
        startTimeTextField.inputView = datePicker
        startTimeTextField.inputAccessoryView = createToolBar()
        startTimeTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startTimeTextField)
        
        descriptionTextView.delegate = self
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.clipsToBounds = true
        descriptionTextView.textColor = .secondaryLabel
        descriptionTextView.isEditable = true
        descriptionTextView.text = "Enter Description Here..."
        descriptionTextView.backgroundColor = .secondarySystemBackground
        descriptionTextView.font = UIFont(name: "Helvetica", size: view.frame.height * 0.02)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionTextView)
        
        
        postButton.clipsToBounds = true
        postButton.backgroundColor = carnellian
        postButton.setTitleColor(.white, for: .normal)
        postButton.setTitle("Post Event!", for: .normal)
        // postButton.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        postButton.layer.cornerRadius = 5
        postButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: view.frame.height * 0.03)
        postButton.addTarget(self, action: #selector(postEvent), for: .touchUpInside)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postButton)
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime

        
        setupConstraints()
    }
    
    func createOtherToolBar() -> UIToolbar {
        let toolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:44))
        toolbar2.sizeToFit()
        let doneButton2 = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(otherDonePressed))
        toolbar2.setItems([doneButton2], animated: true)
        return toolbar2
    }
    
    @objc func freeButtonClicked() {
        if (freeButton.isSelected == false) {
            freeButton.isSelected = true
            freeButton.backgroundColor = .green
        }
        else {
            freeButton.isSelected = false
            freeButton.backgroundColor = carnellian
        }
    }

    func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height:44))
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }
    
    @objc func otherDonePressed() {
        self.view.endEditing(true)
    }
    @objc func donePressed() {
        let date = "\(datePicker.date)".prefix(19)
        print(date)
        self.startTimeTextField.text = "\(date)"
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
            descriptionTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            postButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10),
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc func postEvent() {
        // blah blah check if text fields are empty here
        
        var lastID = 1
        
        if let dateText2 = startTimeTextField.text {
            if (dateText2 == "") {
                return
            }
        }
        
        NetworkManager.shared.getAllEvents {
            events in DispatchQueue.main.async {
//                lastID = events[events.count - 1].id
                lastID = 0
            }
        }
        
        if let titleText = titleTextField.text {
            if let addressText = addressTextField.text {
                if let descriptionText = descriptionTextView.text {
                    if let dateText = startTimeTextField.text {
                        if let chosenCategory = selectedCategory {
                            var free = false
                            if(freeButton.isSelected == true) {
                                free = true
                            }
                            NetworkManager.shared.createEvent(id: lastID, title: titleText, address: addressText, start: dateText, end: "1242-12-10 23:12:12", user: user.name, userEmail: user.email, description: descriptionText, free: free, category: chosenCategory) {
                                event in
                            }
                            errorLabel.text = "Success, Uploaded!"
                            errorLabel.textColor = .green
                            return
                        }
                    }
                }
            }
        }
        
        errorLabel.textColor = .red
        errorLabel.text = "No Upload, Invalid Formatting"
       
        HomeViewController.shared.setupVCs()
        MapViewController.shared.refreshData()
        MapViewController.shared.addAllEvents()
    }
}

extension PostViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: CategoriesCollectionViewCell = categoriesCollectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        
        selectedCategory = cell.category
        for row in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = NSIndexPath(row: row, section: 0)
            
            let cell: UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath) ?? cell
            cell.contentView.backgroundColor = carnellian
        }
        cell.contentView.backgroundColor = vermilion
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

extension PostViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
}
extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
         if(text == "\n") {
             textView.resignFirstResponder()
             return false
         }
         return true
     }
    
}


