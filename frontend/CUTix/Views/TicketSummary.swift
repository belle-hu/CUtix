//
//  TicketSummary.swift
//  CUTix
//
//  Created by Rica Craig on 11/26/23.
//

import UIKit

class NewTicket: UIViewController {
    
    var scrollView: UIScrollView!
    
    let titleLabel = UILabel()
    let titleTextField = UITextField()
    let locationLabel = UILabel()
    let locationTextField = UITextField()
    let dateLabel = UILabel()
    let dateTextField = UITextField()
    let timeLabel = UILabel()
    let startTimeTextField = UITextField()
    let descriptionLabel = UILabel()
    let descriptionTextField = UITextField()
    let addTagsLabel = UILabel()
    let postButton = UIButton()
    
    var filterCollectionView: UICollectionView!
    let filterReuseIdentifier = "filterReuseIdentifier"
    let filterPadding: CGFloat = 5
    var selectedFilter: [String] = []
    var categoryFilter: [String]!
    
    let textFieldHeight = 30
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ticket Summary"
        view.backgroundColor = .white
        
        categoryFilter = ["Concert", "Club", "Sports", "Festivals", "Workshops"]
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named:"backArrow")
        navigationController?.navigationBar.tintColor = .white
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
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
        
        let views: [(String, UILabel, UIView)] = [
            ("Title", titleLabel, titleTextField),
            ("Location", locationLabel, locationTextField),
            ("Date", dateLabel, dateTextField),
            ("Time", timeLabel, startTimeTextField),
            ("Description", descriptionLabel, descriptionTextField),
            ("Tags", addTagsLabel, filterCollectionView)
        ]
        
        var lastView: UIView?
        
        for (labelText, label, field) in views {
            label.text = labelText
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(label)
            
            field.backgroundColor = UIColor.lightGray
            field.layer.cornerRadius = 10
            field.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(field)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
                label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25),
                label.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? scrollView.topAnchor, constant: 25),
                
                field.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
                field.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25),
                field.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
                field.heightAnchor.constraint(equalToConstant: CGFloat(textFieldHeight)),
                field.widthAnchor.constraint(equalToConstant: 300)
            ])
            
            lastView = field
        }
        
        postButton.setTitle("Post Listing", for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        postButton.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
        postButton.layer.masksToBounds = false
        postButton.layer.cornerRadius = 20
        postButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(postButton)
        
        NSLayoutConstraint.activate([
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postButton.topAnchor.constraint(equalTo: lastView?.bottomAnchor ?? scrollView.topAnchor, constant: 30),
            postButton.widthAnchor.constraint(equalToConstant: 334),
            postButton.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        if let lastView = lastView {
            scrollView.bottomAnchor.constraint(equalTo: lastView.bottomAnchor).isActive = true
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
