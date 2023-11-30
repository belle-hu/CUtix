//
//  SellingTicketCollectionView.swift
//  CUTix
//
//  Created by Rica Craig on 11/29/23.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class SellingTicketCollectionView: UICollectionViewCell {
    // MARK: - Properties (view)
    
    private let eventImage = UIImageView()
    private let lowestPrice = UILabel()
    private let ticketDate = UILabel()
    private let ticketIdentifiers = UILabel()
    
    static let reuse = "SellingTicketCollectionViewReuse"

    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupEventImage()
        setupLowestPrice()
        setupTicketDate()
        setupTicketIdentifiers()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(dummyData: Event) {
        lowestPrice.text = dummyData.price
        ticketDate.text = dummyData.month + "\n" + dummyData.year
        ticketIdentifiers.text = """
            \(dummyData.day) - \(dummyData.time)
            \(dummyData.location)
            \(dummyData.organization)
        """
        eventImage.sd_setImage(with: URL(string: dummyData.eventImageUrl))
    }
    
    // MARK: - Set Up Views
    func setupEventImage() {
        eventImage.layer.cornerRadius = 15
        eventImage.layer.masksToBounds = true
        contentView.addSubview(eventImage)
        
        eventImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(219)
        }
    }
    
    func setupLowestPrice() {
        lowestPrice.textColor = .black
        lowestPrice.font = UIFont(name: "SF Pro", size: 30)
        contentView.addSubview(lowestPrice)
        
        lowestPrice.snp.makeConstraints { make in
            make.top.equalTo(eventImage.snp.top).offset(-16)
            make.leading.equalTo(eventImage.snp.leading).offset(252)
        }
    }
    
    func setupTicketDate() {
        ticketDate.textColor = .black
        ticketDate.font = UIFont(name: "SF Pro", size: 20)
        contentView.addSubview(ticketDate)
        
        ticketDate.snp.makeConstraints { make in
            make.leading.equalTo(eventImage.snp.leading).offset(13)
            make.top.equalTo(eventImage.snp.top).offset(-26)
        }
    }
    
    func setupTicketIdentifiers() {
        ticketIdentifiers.textColor = .black
        ticketIdentifiers.font = UIFont(name: "SF Pro", size: 14)
        contentView.addSubview(ticketIdentifiers)
        
        ticketIdentifiers.snp.makeConstraints { make in
            make.top.equalTo(eventImage.snp.top).offset(-34)
            make.leading.equalTo(eventImage.snp.leading).offset(17)
        }
    }
}

