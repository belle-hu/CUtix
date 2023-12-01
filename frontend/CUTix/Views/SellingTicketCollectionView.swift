//
//  SellingTicketCollectionView.swift
//  CUTix
//
//  Created by Rica Craig on 11/30/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class SellingTicketCollectionView: UICollectionViewCell {
    // MARK: - Properties (view)
    
    private let eventImage = UIImageView()
    private let lowestPrice = UILabel()
    private let eventTime = UILabel()
    private let eventId = UILabel()
    private let eventName = UILabel()
    private let eventLocation = UILabel()
    
    static let reuse = "SellingTicketCollectionViewReuse"
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupEventImage()
        setupLowestPrice()
        setupEventName()
        setupEventTime()
        setupEventLocation()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(dummyData: Event) {
        lowestPrice.text = "$" + String(dummyData.price)
        eventName.text = dummyData.name
        eventLocation.text = dummyData.location
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        eventTime.text = dateFormatter.string(from: dummyData.time)
        
        eventImage.sd_setImage(with: URL(string: dummyData.eventImageUrl))
    }
    
    // MARK: - Set Up Views
    
    func setupEventImage() {
        eventImage.layer.cornerRadius = 15
        eventImage.layer.masksToBounds = true
        contentView.addSubview(eventImage)
        
        eventImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(140)
            make.width.equalTo(345)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    func setupLowestPrice() {
        lowestPrice.textColor = .black
        lowestPrice.font = UIFont(name: "SF Pro", size: 20)
        lowestPrice.font = .systemFont(ofSize: 20, weight: .bold)
        contentView.addSubview(lowestPrice)
        
        lowestPrice.snp.makeConstraints { make in
            make.top.equalTo(eventImage.snp.top).offset(16)
            make.trailing.equalTo(eventImage.snp.trailing).offset(-30)
        }
    }
    
    func setupEventName() {
        eventName.textColor = .black
        eventName.font = UIFont(name: "SF Pro", size: 18)
        eventName.font = .systemFont(ofSize: 18, weight: .semibold)
        contentView.addSubview(eventName)
        
        eventName.snp.makeConstraints { make in
            make.leading.equalTo(eventImage.snp.leading).offset(13)
            make.top.equalToSuperview().offset(35)
        }
    }
    
    func setupEventTime() {
        eventTime.textColor = .black
        eventTime.font = UIFont(name: "SF Pro", size: 18)
        eventTime.font = .systemFont(ofSize: 18, weight: .semibold)
        contentView.addSubview(eventTime)
        
        eventTime.snp.makeConstraints { make in
            make.leading.equalTo(eventName.snp.leading)
            make.top.equalTo(eventName.snp.bottom).offset(5)
        }
    }
    
    func setupEventLocation() {
        eventLocation.textColor = .black
        eventLocation.font = UIFont(name: "SF Pro", size: 18)
        eventLocation.font = .systemFont(ofSize: 18, weight: .semibold)
        contentView.addSubview(eventLocation)
        
        eventLocation.snp.makeConstraints { make in
            make.leading.equalTo(eventTime.snp.leading)
            make.top.equalTo(eventTime.snp.bottom).offset(5)
        }
    }
    
}


