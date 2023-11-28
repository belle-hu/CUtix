//
//  TicketSummary.swift
//  CUTix
//
//  Created by Rica Craig on 11/26/23.
//

import UIKit
//import SnapKit

class NewTicket: UIViewController {
    
    var scrollView:UIScrollView!
    
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let locationLabel = UILabel()
    let locationTextField = UITextField()
    let dateLabel = UILabel()
    let dateTextField = UITextField()
    let timeLabel = UILabel()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let addTagsLabel = UILabel()
    let descriptionLabel = UILabel()
    let descriptionTextField = UITextField()
    let postButton = UIButton()
    
    var filterCollectionView: UICollectionView!
    let filterReuseIdentifier = "filterReuseIdentifier"
    let filterPadding: CGFloat = 5
    var selectedFilter: [String] = []
    var categoryFilter: [String]!
    
    let textFieldHeight = 30
    
    weak var delegate: AddTicketDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ticket Summary"
        view.backgroundColor = .white
        
        categoryFilter = ["Concert", "Club", "Sports", "Festivals", "Workshops"]
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.tintColor = .white
        
        scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.contentSize.height = view.bounds.height + 400
        view.addSubview(scrollView)
        
        setupTitleLabel()
        setupTitleTextField()
        setupLocationLabel()
        setupLocationTextField()
        setupDateLabel()
        setupDateTextField()
        setupTimeLabel()
        setupStartTimeTextField()
        setupEndTimeTextField()
        setupDescriptionLabel()
        setupDescriptionTextField()
        setupAddTagsLabel()
    }
        
        func setupTitleLabel() {
            titleLabel.text = "Title"
            titleLabel.textColor = .black
            titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            scrollView.addSubview(titleLabel)
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25),
                titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25)
            ])
        }
        
        func setupTitleTextField() {
            titleTextField.backgroundColor = UIColor.lightGray
            titleTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            titleTextField.borderStyle = .none
            titleTextField.textColor = .black
            titleTextField.layer.cornerRadius = 10
            titleTextField.clearButtonMode = .always
            scrollView.addSubview(titleTextField)
            
            NSLayoutConstraint.activate([
                titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                titleTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 35),
                titleTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -35),
                titleTextField.heightAnchor.constraint(equalToConstant: CGFloat(textFieldHeight))
            ])
        }
        
        func setupLocationLabel() {
            locationLabel.text = "Location"
            locationLabel.textColor = .black
            locationLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            scrollView.addSubview(locationLabel)
            
            NSLayoutConstraint.activate([
                locationLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 35),
                locationLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 25)
            ])
        }
        
        func setupLocationTextField() {
            locationTextField.placeholder = "Location"
            locationTextField.backgroundColor = UIColor.lightGray
            locationTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            locationTextField.borderStyle = .none
            locationTextField.textColor = .darkGray
            locationTextField.layer.cornerRadius = 10
            locationTextField.clearButtonMode = .always
            scrollView.addSubview(locationTextField)
            
            NSLayoutConstraint.activate([
                locationTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30),
                locationTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -30),
                locationTextField.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
                locationTextField.heightAnchor.constraint(equalToConstant: CGFloat(textFieldHeight))
            ])
        }
        
        func setupDateLabel() {
            dateLabel.text = "Date"
            dateLabel.textColor = .black
            dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            scrollView.addSubview(dateLabel)
            
            NSLayoutConstraint.activate([
                dateLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 35),
                dateLabel.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 25)
            ])
        }
        
        func setupDateTextField() {
            dateTextField.placeholder = " mm/dd/yyyy"
            dateTextField.backgroundColor = UIColor.lightGray
            dateTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            dateTextField.borderStyle = .none
            dateTextField.textColor = .darkGray
            dateTextField.layer.cornerRadius = 10
            dateTextField.clearButtonMode = .always
            scrollView.addSubview(dateTextField)
            
            NSLayoutConstraint.activate([
                dateTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
                dateTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
                dateTextField.heightAnchor.constraint(equalToConstant: CGFloat(textFieldHeight)),
                dateTextField.widthAnchor.constraint(equalToConstant: 115)
            ])
        }
        
        func setupTimeLabel() {
            timeLabel.text = "Time"
            timeLabel.textColor = .black
            timeLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            scrollView.addSubview(timeLabel)
            
            NSLayoutConstraint.activate([
                timeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30),
                timeLabel.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 20)
            ])
        }
        
        func setupStartTimeTextField() {
            startTimeTextField.placeholder = " from"
            startTimeTextField.backgroundColor = UIColor.lightGray
            startTimeTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            startTimeTextField.borderStyle = .none
            startTimeTextField.textColor = .darkGray
            startTimeTextField.layer.cornerRadius = 10
            startTimeTextField.clearButtonMode = .always
            scrollView.addSubview(startTimeTextField)
            
            NSLayoutConstraint.activate([
                startTimeTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
                startTimeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
                startTimeTextField.heightAnchor.constraint(equalToConstant: CGFloat(textFieldHeight)),
                startTimeTextField.widthAnchor.constraint(equalToConstant: 85)
            ])
        }
        
        func setupEndTimeTextField() {
            endTimeTextField.placeholder = " to"
            endTimeTextField.backgroundColor = UIColor.lightGray
            endTimeTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            endTimeTextField.borderStyle = .none
            endTimeTextField.textColor = .darkGray
            endTimeTextField.layer.cornerRadius = 10
            endTimeTextField.clearButtonMode = .always
            scrollView.addSubview(endTimeTextField)
            
            NSLayoutConstraint.activate([
                endTimeTextField.leftAnchor.constraint(equalTo: startTimeTextField.rightAnchor, constant: 10),
                endTimeTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
                endTimeTextField.heightAnchor.constraint(equalToConstant: CGFloat(textFieldHeight)),
                endTimeTextField.widthAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        func setupDescriptionLabel() {
            descriptionLabel.text = "Description"
            descriptionLabel.textColor = .black
            descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            scrollView.addSubview(descriptionLabel)
            
            NSLayoutConstraint.activate([
                descriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
                descriptionLabel.topAnchor.constraint(equalTo: startTimeTextField.bottomAnchor, constant: 25)
            ])
        }
        
        func setupDescriptionTextField() {
            descriptionTextField.placeholder = "Write a description..."
            descriptionTextField.backgroundColor = UIColor.lightGray
            descriptionTextField.textColor = .darkGray
            descriptionTextField.layer.cornerRadius = 10
            descriptionTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            scrollView.addSubview(descriptionTextField)
            
            NSLayoutConstraint.activate([
                descriptionTextField.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25),
                descriptionTextField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25),
                descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
                descriptionTextField.heightAnchor.constraint(equalToConstant: 110)
            ])
        }
    
        func setupAddTagsLabel() {
            addTagsLabel.text = "Tags"
            addTagsLabel.textColor = .black
            addTagsLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            scrollView.addSubview(addTagsLabel)
            
            NSLayoutConstraint.activate([
                addTagsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                addTagsLabel.topAnchor.constraint(equalTo: startTimeTextField.bottomAnchor, constant: 15)
            ])
        }
            
        func setupPostButton() {
            postButton.setTitle("Post Listing", for: .normal)
            postButton.setTitleColor(UIColor.lightGray, for: .normal)
            postButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            postButton.backgroundColor = .white
            postButton.addTarget(self, action: #selector(post), for: .touchUpInside)
            postButton.layer.masksToBounds = false
            postButton.layer.cornerRadius = 20
            postButton.layer.borderWidth = 2
            postButton.layer.borderColor = UIColor.lightGray.cgColor
            scrollView.addSubview(postButton)
            
            NSLayoutConstraint.activate([
                postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                postButton.widthAnchor.constraint(equalToConstant: 90),
                postButton.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
            
        func setupFilterCollectionView() {
            let filterLayout = UICollectionViewFlowLayout()
            filterLayout.scrollDirection = .vertical
            filterLayout.minimumInteritemSpacing = filterPadding
            filterLayout.minimumLineSpacing = filterPadding
            filterLayout.sectionInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0)
            filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
            filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
            filterCollectionView.backgroundColor = .clear
            filterCollectionView.allowsMultipleSelection = true
            filterCollectionView.dataSource = self
            filterCollectionView.delegate = self
            filterCollectionView.register(TagFilterCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
            scrollView.addSubview(filterCollectionView)

            NSLayoutConstraint.activate([
                filterCollectionView.topAnchor.constraint(equalTo: addTagsLabel.bottomAnchor, constant: 5),
                filterCollectionView.heightAnchor.constraint(equalToConstant: 50),
                filterCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
                filterCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15)
            ])
        }
            
        func makeAlert() {
            let alert = UIAlertController(title: "Post Cannot Be Added:", message: "Please fill out all areas", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
        
        @objc func post() {
            if let title = titleTextField.text, let location = locationTextField.text, let date = dateTextField.text, let fromTime = startTimeTextField.text, let toTime = endTimeTextField.text, let eventDetail = descriptionTextField.text {
                if title == "" || location == "" || date == "" || fromTime == "" || toTime == "" || eventDetail == "" {
                    makeAlert()
                } else {
                    delegate?.addNewTicket(to: title, to: location, to: date, to: fromTime, to: toTime, to: eventDetail, to: selectedFilter)
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    extension NewTicket: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let currentFilter = categoryFilter[indexPath.item]
            updateFilter(filter: currentFilter, needRemoved: false)
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let currentFilter = categoryFilter[indexPath.item]
            updateFilter(filter: currentFilter, needRemoved: true)
        }
        
        func updateFilter(filter: String, needRemoved: Bool = false) {
            if needRemoved {
                selectedFilter.remove(at: selectedFilter.firstIndex(of: filter)!)
            } else {
                if !(selectedFilter.contains(filter)) {
                    selectedFilter.append(filter)
                }
            }
        }
    }
    
    extension NewTicket: UICollectionViewDataSource {
        func numberOfItems(inSection section: Int) -> Int {
            return categoryFilter.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categoryFilter.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let tagfilterCell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as! TagFilterCell
            let category = categoryFilter[indexPath.item]
            tagfilterCell.configure(for: category)
            return tagfilterCell
        }
    }
    
    extension NewTicket: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width: CGFloat = 75
            let height: CGFloat = 35
            return CGSize(width: width, height: height)
        }
    }


