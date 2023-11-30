//
//  TicketInfoVC.swift
//  CUTix
//
//  Created by Maisie Yan on 11/29/23.
//

import Foundation
import UIKit
import SnapKit

class TicketInfoVC: UIViewController {
    
    // MARK: - Properties (view)
    private let refreshControl = UIRefreshControl()
    private let nameLabel = UILabel()
    private let dateLocationLabel = UILabel()
    private let firstLine = UILabel()
    private let secondLine = UILabel()
    private let descriptionLabel = UILabel()
    private let descriptionText = UILabel()
    private let aboutSellerLabel = UILabel()
    private let profileImage = UIImageView()
    private let usernameLabel = UILabel()
    private let contactSellerButton = UIButton()
    private let makeOfferButton = UIButton()
    
    // MARK: - Properties (data)
    private var ticket: Ticket
    private var event: Event
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupName()
        setupDateLocation()
        setupFirstLine()
        setupSecondLine()
        setupDescriptionLabel()
        setupDescriptionText()
        setupAboutSellerLabel()
        setupProfileImage()
        setupSellerUsername()
        setupContactSellerButton()
        setupMakeOfferButton()
    }
    
    init(ticket: Ticket, event: Event) {
        self.ticket = ticket
        nameLabel.text = event.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        dateLocationLabel.text = dateFormatter.string(from: event.time) + " - " + event.location
        self.event = event
        usernameLabel.text = String(ticket.holderId)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func configure() {
    }
    
    
    // MARK: - Set Up Views
    
    private func setupName() {
        nameLabel.font = UIFont(name: "SF Pro", size: 20)
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.top.equalToSuperview().offset(125)
        }
    }
    
    private func setupDateLocation() {
        dateLocationLabel.font = UIFont(name: "SF Pro", size: 20)
        dateLocationLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        dateLocationLabel.numberOfLines = 2
        view.addSubview(dateLocationLabel)
        
        dateLocationLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(10)
        }
    }
    
    private func setupFirstLine() {
        firstLine.backgroundColor = .black
        view.addSubview(firstLine)
        
        firstLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(dateLocationLabel.snp.bottom).offset(25)
            make.height.equalTo(1)
        }
    }
    
    private func setupSecondLine() {
        secondLine.backgroundColor = .black
        view.addSubview(secondLine)
        
        secondLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(firstLine.snp.bottom).offset(478)
            make.height.equalTo(1)
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.text = "Description: "
        descriptionLabel.font = UIFont(name: "SF Pro", size: 20)
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLocationLabel.snp.leading)
            make.top.equalTo(firstLine.snp.bottom).offset(34)
        }
        
    }
    
    private func setupDescriptionText() {
        descriptionText.text = "fbdhicbdwhicbshicjnakxmcudbiyvfgbcj snkjxuehwfygrvhdbcjsnkjxaduwehfygrvhdbcjsnkjeuhfrybdjcnkseuhfbjdcnksewufh"
        descriptionText.numberOfLines = 3
        descriptionText.font = UIFont(name: "SF Pro", size: 14)
        view.addSubview(descriptionText)
        
        descriptionText.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(37)
            make.trailing.equalToSuperview().offset(-37)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(18)
        }
    }
    
    private func setupAboutSellerLabel() {
        aboutSellerLabel.text = "About this Seller:"
        aboutSellerLabel.font = UIFont(name: "SF Pro", size: 20)
        aboutSellerLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(aboutSellerLabel)
        
        aboutSellerLabel.snp.makeConstraints { make in
            make.leading.equalTo(descriptionLabel.snp.leading)
            make.top.equalTo(descriptionText.snp.bottom).offset(24)
        }
    }
    
    private func setupProfileImage() {
        profileImage.image = UIImage(named: "offerPfp")
        view.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.leading.equalTo(aboutSellerLabel.snp.leading)
            make.top.equalTo(aboutSellerLabel.snp.bottom).offset(32)
        }
    }
    
    private func setupSellerUsername() {
        usernameLabel.font = UIFont(name: "SF Pro", size: 12)
        usernameLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        view.addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(7)
            make.top.equalTo(aboutSellerLabel.snp.bottom).offset(31)
        }
    }
    
    private func setupContactSellerButton() {
        contactSellerButton.setTitle("Contact Seller", for: .normal)
        contactSellerButton.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
        contactSellerButton.setTitleColor(UIColor.white, for: .normal)
        contactSellerButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        contactSellerButton.layer.cornerRadius = 20
        view.addSubview(contactSellerButton)
        
        contactSellerButton.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(41)
        }
    }
    
    private func setupMakeOfferButton() {
        makeOfferButton.setTitle("Make Offer", for: .normal)
        makeOfferButton.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
        makeOfferButton.setTitleColor(UIColor.white, for: .normal)
        makeOfferButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        makeOfferButton.layer.cornerRadius = 20
        view.addSubview(makeOfferButton)
        
        makeOfferButton.snp.makeConstraints { make in
            make.top.equalTo(contactSellerButton.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(41)
        }
    }
    
}
