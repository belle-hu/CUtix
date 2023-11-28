//
//  DetailedCollectionView.swift
//  CUTix
//
//  Created by Maisie Yan on 11/26/23.
//

import Foundation
import UIKit
import SnapKit

class DetailedEventCollectionView: UICollectionViewCell {
    // MARK: - Properties (view)

    private let eventImage = UIImageView()
    private let eventTitle = UILabel()
    private let availableTitle = UILabel()
    private let ticketDate = UILabel()
    private let ticketIdentifiers = UILabel()
    private let ticketPrice = UILabel()
    private let ticketImage = UIImageView()

    // MARK: - Properties (data)
    static let reuse = "DetailedEventCollectionView"

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupEventTitle()
        setupAvailableTitle()
        setupEventImage()
        setupLowestPrice()
        setupTicketDate()
        setupTicketIdentifiers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }

    func configure(dummyData: Event) {
        eventTitle.text = dummyData.eventType
        ticketPrice.text = dummyData.price
        ticketDate.text = dummyData.month + "\n" + dummyData.year
        ticketIdentifiers.text = """
            \(dummyData.day) - \(dummyData.time)
            \(dummyData.location)
            \(dummyData.organization)
        """
        ticketImage.image = UIImage(named: dummyData.ticketImageUrl)
    }
    
    // MARK: - Set Up Views
    
    func setupEventTitle() {
        eventTitle.font = UIFont(name: "SF Pro", size: 32)
        contentView.addSubview(eventTitle)
        
        eventTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-187)
            make.top.equalToSuperview().offset(81)
        }
    }
    
    func setupAvailableTitle() {
        availableTitle.text = "Available Tickets"
        availableTitle.font = UIFont(name: "SF Pro", size: 32)
        contentView.addSubview(availableTitle)
        
        eventTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
        }
    }
    
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
        ticketPrice.textColor = .black
        ticketPrice.font = UIFont(name: "SF Pro", size: 30)
        contentView.addSubview(ticketPrice)
        
        ticketPrice.snp.makeConstraints { make in
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

