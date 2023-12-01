//
//  SellViewController.swift
//  CUTix
//
//  Created by Maisie Yan on 11/28/23.
//

import Foundation
import UIKit
import SnapKit

class SellViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private var collectionViewSelling: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private let eventTitle = UILabel()
    
    private let searchButton = UIButton()
    private let moneyButton = UIButton()
    private let profileButton = UIButton()
    
    private let redBanner = UILabel()
    private let bottomBanner = UILabel()
    private let CutixTitle = UILabel()
    private let sellticketButton = UIButton()
    
    // MARK: - Properties (data)
    var dummyData: [Event] = [Event(id: 0987, name: "Football: Cornell vs Colgate", time: Date(timeIntervalSince1970: 1701399802), category: "Sports", location: "Ithaca", price: 20.00, eventImageUrl: "https://re-mm-assets.s3.amazonaws.com/product_photo/20404/large_Poly_LightPink_7422up_1471501981.jpg"), Event(id: 5542, name: "Class Notes Concert", time: Date(timeIntervalSince1970: 1701399837), category: "Concerts", location: "Ithaca", price: 10.00, eventImageUrl: "https://re-mm-assets.s3.amazonaws.com/product_photo/20404/large_Poly_LightPink_7422up_1471501981.jpg"), Event(id: 9876, name: "Track and Field Meet", time: Date(timeIntervalSince1970: 1708399200), category: "Sports", location: "Ithaca", price: 8.00, eventImageUrl: "https://re-mm-assets.s3.amazonaws.com/product_photo/20404/large_Poly_LightPink_7422up_1471501981.jpg"), Event(id: 332, name: "DIY Workshop", time: Date(timeIntervalSince1970: 1718399300), category: "Workshops", location: "Upson", price: 5.00, eventImageUrl: "https://re-mm-assets.s3.amazonaws.com/product_photo/20404/large_Poly_LightPink_7422up_1471501981.jpg")
    ]
    
    var allEvents: [Event] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        navigationController?.navigationBar.prefersLargeTitles = true
        

        allEvents = dummyData
        setupBottomBanner()
        setupEventTitle()
        setupCollectionViewSelling()
        setupButtons()
        setupSellTicketButton()        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func setupEventTitle() {
        eventTitle.text = "Currently Selling"
        eventTitle.textColor = .black
        eventTitle.font = UIFont(name: "SF Pro", size: 32)
        eventTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        
        view.addSubview(eventTitle)
        
        eventTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(110)
            make.bottom.equalToSuperview().offset(-664)
        }
        
    }
    
    private func setupCollectionViewSelling() {
        // Create a FlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 16
        
        // Initialize CollectionView with the layout
        collectionViewSelling = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewSelling.register(SellingTicketCollectionView.self, forCellWithReuseIdentifier: SellingTicketCollectionView.reuse)
        collectionViewSelling.delegate = self
        collectionViewSelling.dataSource = self
        collectionViewSelling.alwaysBounceVertical = true

        view.addSubview(collectionViewSelling)
        
        collectionViewSelling.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.bottom.equalTo(bottomBanner.snp.top)
        }
        
    }
    
    private func setupSellTicketButton() {
        let whiteRectangle = UIView()
        whiteRectangle.backgroundColor = UIColor.white

        self.view.addSubview(whiteRectangle)

        whiteRectangle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(92)
            make.bottom.equalTo(-41)
        }

        sellticketButton.setTitle("Sell Tickets", for: .normal)
        sellticketButton.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
        sellticketButton.setTitleColor(UIColor.white, for: .normal)
        sellticketButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        sellticketButton.layer.cornerRadius = 20

        whiteRectangle.addSubview(sellticketButton)

        sellticketButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(41)
            make.width.equalToSuperview().offset(-40)
        }

        sellticketButton.addTarget(self, action: #selector(sellticketButtonTapped), for: .touchUpInside)
    }

    @objc private func searchButtonTapped() {
        let eventViewController = EventViewController()
        navigationController?.pushViewController(eventViewController, animated: true)
    }
    
    @objc func sellticketButtonTapped() {
        let newTicketViewController = NewTicket()
        self.navigationController?.pushViewController(newTicketViewController, animated: true)
    }
        
    @objc private func moneyButtonTapped() {
        let sellViewController = SellViewController()
        navigationController?.pushViewController(sellViewController, animated: true)
    }
    
    @objc private func profileButtonTapped() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    

    
    private func setupButtons() {
        searchButton.setImage(UIImage(named: "whiteSearch"), for: .normal)
        profileButton.setImage(UIImage(named: "whiteProfile"), for: .normal)
        moneyButton.setImage(UIImage(named: "whiteMoney"), for: .normal)
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        moneyButton.addTarget(self, action: #selector(moneyButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
  
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
extension SellViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SellingTicketCollectionView.reuse, for: indexPath) as? SellingTicketCollectionView else { return UICollectionViewCell() }
            cell.configure(dummyData: dummyData[indexPath.row])
        return cell
        }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension SellViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width - 16
            let height : CGFloat = 126
            return CGSize(width: width, height: height)
    }
}

