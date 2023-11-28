//
//  TicketViewController.swift
//  CUTixApp
//
//  Created by Maisie Yan on 11/18/23.
//

import Foundation
import UIKit
import SnapKit

protocol AddTicketDelegate: AnyObject {
    func addNewTicket(to title: String, to location: String, to date: String, to fromTime: String, to toTime: String, to eventDetail: String, to tags: [String])
}

class TicketViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private var collectionViewOne: UICollectionView!
    private var filterCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties (data)
    let filters: [String] = ["All", "Concert", "Club", "Sports", "Festivals", "Workshops"]
    
    var dummyData: [Event] = [Event(id: "id", month: "March", year: "2023", day: "Tuesday", time: "8:00 PM", location: "Ithaca", organization: "organization", eventType: "Sports", price: "$20.00", ticketImageUrl: "https://www.ledr.com/colours/grey.jpg", eventImageUrl: "https://www.ledr.com/colours/grey.jpg")]
    
    var allEvents: [Event] = []
    var filtered: [Event] = []
    var filterEvents: String? = nil
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        title = "CUTix"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        filtered = dummyData
        
        setupCollectionView()
        setupHorizCollectionView()
    }
    
    private func setupHorizCollectionView() {
        let horizlayout = UICollectionViewFlowLayout()
        horizlayout.scrollDirection = .horizontal
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: horizlayout)
        filterCollectionView.register(FilterCollectionView.self, forCellWithReuseIdentifier: FilterCollectionView.reuse)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.alwaysBounceHorizontal = true
        
        view.addSubview(filterCollectionView)
        
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(32)
            make.width.equalTo(116)
        }
    }
    
    private func setupCollectionView() {
        // Create a FlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        // Initialize CollectionView with the layout
        collectionViewOne = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewOne.register(TicketCollectionView.self, forCellWithReuseIdentifier: TicketCollectionView.reuse)
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        collectionViewOne.alwaysBounceVertical = true

        view.addSubview(collectionViewOne)
        
        collectionViewOne.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(234)
            make.trailing.bottom.leading.equalToSuperview()
        }
        
    }
    
}

// MARK: - UICollectionView DataSource
extension TicketViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewOne {
            return filtered.count
        }
        else if collectionView == filterCollectionView {
            return filters.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewOne{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCollectionView.reuse, for: indexPath) as? TicketCollectionView else { return UICollectionViewCell() }
            cell.configure(dummyData: filtered[indexPath.row])
            return cell
        }
        else if collectionView == filterCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionView.reuse, for: indexPath) as? FilterCollectionView else { return UICollectionViewCell() }
            let filter = filters[indexPath.item]
            let selected = filter == filterEvents
            cell.configure(filter: filter, isSelected: selected)
            return cell
        }
        return UICollectionViewCell()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension TicketViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewOne {
            let width = collectionView.frame.width - 16
            let height : CGFloat = 126
            return CGSize(width: width, height: height)
        }
        else if collectionView == filterCollectionView {
            let width : CGFloat = 116
            let height : CGFloat = 32
            return CGSize(width: width, height: height)
        }
        return CGSize(width: 100, height: 100)
    }
}

extension TicketViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewOne {
            let selected = filtered[indexPath.row]
            let detailedVC = DetailedVC(event: filtered[indexPath.row])
            navigationController?.pushViewController(detailedVC, animated: true)
        }
        else if collectionView == filterCollectionView {
            filterEvents = filters[indexPath.item]
            if filterEvents == "All" {
                filtered = allEvents
            } else {
                if let events = filterEvents {
                    filtered = dummyData.filter { $0.eventType == events }
                }
            }
        }
        collectionViewOne.reloadData()
        filterCollectionView.reloadData()
        
    }
    
}
