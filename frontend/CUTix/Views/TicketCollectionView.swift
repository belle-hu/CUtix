//
//  TicketCollectionView.swift
//  CUTix
//
//  Created by Maisie Yan on 11/18/23.
//

import Foundation
import UIKit
import SnapKit

class TicketCollectionView: UICollectionViewCell {
    // MARK: - Properties (view)
    
    private let ticketImage = UIImageView()
    private let ticketPrice = UILabel()
    private let ticketDate = UILabel()
    private let ticketIdentifiers = UILabel()
    
    static let reuse = "TicketCollectionViewReuse"

    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(dummyData: Ticket) {
        ticketPrice.text = dummyData.price
        ticketDate.text = dummyData.month + "\n" + dummyData.year
        ticketIdentifiers.text = """
            \(dummyData.day) - \(dummyData.time)
            \(dummyData.location)
            \(dummyData.organization)
        """
        ticketImage.image = UIImage(named: dummyData.imageUrl)
    }
    
    // MARK: - Set Up Views
    func setupTicketImage() {
        ticketImage.layer.cornerRadius = 15
        ticketImage.layer.masksToBounds = true
        contentView.addSubview(ticketImage)
        
        ticketImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(219)
        }
    }
    
    func setupTicketPrice() {
        ticketPrice.textColor = .black
        ticketPrice.font = UIFont(name: "SF Pro", size: 30)
        contentView.addSubview(ticketPrice)
        
        ticketPrice.snp.makeConstraints { make in
            make.top.equalTo(ticketImage.snp.top).offset(-16)
            make.leading.equalTo(ticketImage.snp.leading).offset(252)
        }
    }
    
    func setupTicketDate() {
        ticketDate.textColor = .black
        ticketDate.font = UIFont(name: "SF Pro", size: 20)
        contentView.addSubview(ticketDate)
        
        ticketDate.snp.makeConstraints { make in
            make.leading.equalTo(ticketImage.snp.leading).offset(13)
            make.top.equalTo(ticketImage.snp.top).offset(-26)
        }
    }
    
    func setupTicketIdentifiers() {
        ticketIdentifiers.textColor = .black
        ticketIdentifiers.font = UIFont(name: "SF Pro", size: 14)
        contentView.addSubview(ticketIdentifiers)
        
        ticketIdentifiers.snp.makeConstraints { make in
            make.top.equalTo(ticketImage.snp.top).offset(-34)
            make.leading.equalTo(ticketImage.snp.leading).offset(17)
        }
    }
}

