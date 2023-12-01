//
//  TicketCollectionView.swift
//  CUTix
//
//  Created by Maisie Yan on 11/26/23.
//

import Foundation
import UIKit
import SnapKit

class TicketCollectionView: UICollectionViewCell {
    // MARK: - Properties (view)

    private let ticketTime = UILabel()
    private let ticketPrice = UILabel()
    private let ticketImage = UIImageView()
    private let ticketName = UILabel()

    // MARK: - Properties (data)
    static let reuse = "TicketCollectionView"

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTicketImage()
        setupTicketPrice()
        setupTicketTime()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }

    func configure(event: Event, ticket: Ticket) {
        ticketPrice.text = "$" + String(ticket.cost)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        ticketTime.text = dateFormatter.string(from: event.time)
        ticketImage.sd_setImage(with: URL(string: event.eventImageUrl))
    }
    
    // MARK: - Set Up Views
    
    func setupTicketImage() {
        ticketImage.layer.cornerRadius = 15
        ticketImage.layer.masksToBounds = true
        contentView.addSubview(ticketImage)
        
        ticketImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(140)
            make.width.equalTo(345)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
        
    func setupTicketPrice() {
        ticketPrice.textColor = .black
        ticketPrice.font = UIFont(name: "SF Pro", size: 30)
        ticketPrice.font = .systemFont(ofSize: 30, weight: .semibold)
        contentView.addSubview(ticketPrice)
        
        ticketPrice.snp.makeConstraints { make in
            make.top.equalTo(ticketImage.snp.top).offset(50)
            make.trailing.equalTo(ticketImage.snp.trailing).offset(-30)
        }
    }
    
    func setupTicketTime() {
        ticketTime.textColor = .black
        ticketTime.font = UIFont(name: "SF Pro", size: 20)
        ticketTime.font = .systemFont(ofSize: 20, weight: .semibold)
        ticketTime.numberOfLines = 2
        contentView.addSubview(ticketTime)
        
        ticketTime.snp.makeConstraints { make in
            make.leading.equalTo(ticketImage.snp.leading).offset(8)
            make.trailing.equalToSuperview().offset(-100)
            make.top.equalTo(ticketImage.snp.top).offset(20)
        }
    }
    
}

