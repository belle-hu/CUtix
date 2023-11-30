//
//  SellingViewController.swift
//  CUTix
//
//  Created by Rica Craig on 11/29/23.
//

import UIKit

protocol AddTicketDelegate: AnyObject {
    func addNewTicket(to title: String, to location: String, to date: String, to fromTime: String, to toTime: String, to eventDetail: String, to tags: [String])
}

class SellingTicketViewController: UIViewController{
    
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    // Initialize your data array
    let filters: [String] = ["All", "Concert", "Club", "Sports", "Festivals", "Workshops"]
    
    var dummyData: [Event] = [Event(id: "id", month: "March", year: "2023", day: "Tuesday", time: "8:00 PM", location: "Ithaca", organization: "organization", eventType: "Sports", price: "$20.00", ticketImageUrl: "jpg1", eventImageUrl: "jpg2")]
    
    var allEvents: [Flow3TestTicket] = []
    var filtered: [Flow3TestTicket] = []
    var filterEvents: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Currently Selling"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.lightGray
        
        setupCollectionView()
        
//        let layout = UICollectionViewFlowLayout()
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .lightGray
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        
//        collectionView.register(SellingTicketCollectionView.self, forCellWithReuseIdentifier: SellingTicketCollectionView.reuse)
//        
//        view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        dummyData = [
            Event(id: "id", month: "March", year: "2023", day: "Tuesday", time: "8:00 PM", location: "Ithaca", organization: "organization", eventType: "Sports", price: "$20.00", ticketImageUrl: "jpg3", eventImageUrl: "jpg4"),
            Event(id: "id", month: "March", year: "2023", day: "Tuesday", time: "8:00 PM", location: "Ithaca", organization: "organization", eventType: "Sports", price: "$20.00", ticketImageUrl: "jpg3", eventImageUrl: "jpg5"),
        ]


    }
    
    private func setupCollectionView() {
        
        let padding: CGFloat = 24   // Use this constant when configuring constraints
        
        // TODO: Set Up CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.backgroundColor = UIColor.lightGray
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
       ])
     
        collectionView.isScrollEnabled = true
    }
    
}

    // MARK: - UICollectionViewDataSource methods
    
extension func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Return the number of rows for each section
        if section == 0 {
            return 1
        }
        return dummyData.count
    }
extension func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SellingTicketCollectionView.reuse, for: indexPath) as! SellingTicketCollectionView
        
        // Configure your cell
        cell.configure(dummyData: dummyData[indexPath.row])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }

