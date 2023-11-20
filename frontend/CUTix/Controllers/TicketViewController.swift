//
//  TicketViewController.swift
//  CUTixApp
//
//  Created by Maisie Yan on 11/18/23.
//

import Foundation
import UIKit
import SnapKit

class TicketViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private var collectionViewOne: UICollectionView!
    private var filterCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties (data)
    let filters: [String] = ["All", "Concert", "Club", "Sports", "Festivals", "Workshops"]
    
    var dummyData: [Ticket] = [Ticket(id: "id", month: "March", year: "2023", day: "Tuesday", time: "8:00 PM", location: "Ithaca", organization: "organization", price: "$20.00", imageUrl: "https://t4.ftcdn.net/jpg/02/23/36/01/360_F_223360125_GjNeYSEaIaJoCzSKVMcMhw1LV9A2HpuO.webp")]
    
    var allTickets: [Ticket] = []
    var filtered: [Ticket] = []
    var filterEvents: String? = nil
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        title = "CUTix"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
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
        collectionViewOne.alwaysBounceVertical = true

        view.addSubview(collectionViewOne)
        
        collectionViewOne.snp.makeConstraints { make in
            make.trailing.bottom.leading.equalToSuperview()
        }
        
    }
    
}

// MARK: - UICollectionView DataSource
