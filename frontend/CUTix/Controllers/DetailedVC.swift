//
//  DetailedVC.swift
//  CUTix
//
//  Created by Maisie Yan on 11/26/23.
//

import Foundation
import UIKit
import SnapKit

class DetailedVC: UIViewController {
    
    // MARK: - Properties (view)
    private var ticketCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private let availableTitle = UILabel()
    private let ticketTitle = UILabel()
    private let searchButton = UIButton()
    private let moneyButton = UIButton()
    private let profileButton = UIButton()
    private let bottomBanner = UILabel()
    
    // MARK: - Properties (data)
    private var event: Event
    //private var user: User
    
    var dummyData: [Ticket] = [Ticket(id:3581, cost: 13, holderId: 56, isSelling: true, eventId: 1234), Ticket(id: 32542, cost: 80, holderId: 16, isSelling: true, eventId: 9876)]
    var matchedTickets: [Ticket] {
        return dummyData.filter { $0.eventId == event.id }
    }
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupTicketTitle()
        setupAvailableTitle()
        setupCollectionView()
        setupBottomBanner()
        setupButtons()
    }
    
    init(event: Event) {
        self.event = event
        ticketTitle.text = event.name
        //ticketpriceLabel.text = String(event.price)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func configure() {
        
    }
    
    
    // MARK: - Set Up Views

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 16
        
        // Initialize CollectionView with the layout
        ticketCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ticketCollectionView.register(TicketCollectionView.self, forCellWithReuseIdentifier: TicketCollectionView.reuse)
        ticketCollectionView.delegate = self
        ticketCollectionView.dataSource = self
        ticketCollectionView.alwaysBounceVertical = true

        view.addSubview(ticketCollectionView)
        
        ticketCollectionView.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalToSuperview()
            make.top.equalTo(availableTitle.snp.bottom).offset(7)
        }
        
    }
    
    func setupAvailableTitle() {
        availableTitle.text = "Available Tickets"
        availableTitle.font = UIFont(name: "SF Pro", size: 32)
        availableTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        view.addSubview(availableTitle)
        
        availableTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ticketTitle.snp.bottom).offset(35)
        }
    }
    
    func setupTicketTitle() {
        ticketTitle.font = UIFont(name: "SF Pro", size: 32)
        ticketTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        ticketTitle.numberOfLines = 2
        view.addSubview(ticketTitle)
        
        ticketTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().offset(18)
        }
    }

    
    @objc private func moneyButtonTapped() {
        let sellViewController = SellViewController()
        navigationController?.pushViewController(sellViewController, animated: true)
    }
    
    @objc private func profileButtonTapped() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    @objc private func searchButtonTapped() {
        navigationController?.popViewController(animated: true)
        
    }
    
    private func setupButtons() {
        searchButton.setImage(UIImage(named: "whiteSearch"), for: .normal)
        profileButton.setImage(UIImage(named: "whiteProfile"), for: .normal)
        moneyButton.setImage(UIImage(named: "whiteMoney"), for: .normal)
        
        moneyButton.addTarget(self, action: #selector(moneyButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        view.addSubview(searchButton)
        view.addSubview(profileButton)
        view.addSubview(moneyButton)
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13)
            make.leading.equalToSuperview().offset(72)
        }
        
        moneyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-7)
            make.centerX.equalToSuperview()
            make.width.equalTo(41)
            make.height.equalTo(38)
        }
        
        profileButton.snp.makeConstraints { make in
            make.bottom.equalTo(moneyButton.snp.bottom).offset(-5)
            make.trailing.equalToSuperview().offset(-72)
            make.size.equalTo(30)
        }
    }
    
    private func setupBottomBanner() {
        bottomBanner.backgroundColor = UIColor(red: 0.7, green: 0.11, blue: 0.11, alpha: 1)
        view.addSubview(bottomBanner)
        
        bottomBanner.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(42)
        }
    }

    
}

// MARK: - UICollectionView DataSource
extension DetailedVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matchedTickets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCollectionView.reuse, for: indexPath) as? TicketCollectionView else { return UICollectionViewCell() }
        cell.configure(event: event, ticket: matchedTickets[indexPath.row])
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 16
        let height : CGFloat = 126
        return CGSize(width: width, height: height)
    }
}

extension DetailedVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = dummyData[indexPath.row]
        let ticketInfoVC = TicketInfoVC(ticket: dummyData[indexPath.row], event: event)
        navigationController?.pushViewController(ticketInfoVC, animated: true)
        
        ticketCollectionView.reloadData()
    }
    
}

