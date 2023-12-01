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
    private let sellerUsername = UILabel()
    private let contactSellerButton = UIButton()
    private let makeOfferButton2 = UIButton()
    private let subtotalLabel = UILabel()
    private let dollarLabel = UILabel()
    private let ticketpriceLabel = UILabel()
    private let purchaseButton = UIButton()
    
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
        setupMakeOfferButton2()
        setupTicketPriceLabel()
        setupSubtotalLabel()
        setupDollarLabel()
        setupPurchaseButton()
    }
    
    init(ticket: Ticket, event: Event) {
        self.ticket = ticket
        nameLabel.text = event.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        dateLocationLabel.text = dateFormatter.string(from: event.time) + " - " + event.location
        self.event = event
        //sellerUsername.text = user.name
        sellerUsername.text = String(ticket.holderId)
        ticketpriceLabel.text = String(ticket.cost)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func configure() {
    }
    
    
    // MARK: - Set Up Views
    
    private func setupName() {
        nameLabel.font = UIFont(name: "SF Pro", size: 24)
        nameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.top.equalToSuperview().offset(100)
            //make.leading.equalToSuperview().offset(18)
        }
    }
    
    private func setupDateLocation() {
        dateLocationLabel.font = UIFont(name: "SF Pro", size: 24)
        dateLocationLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        dateLocationLabel.numberOfLines = 0
        view.addSubview(dateLocationLabel)
        
        dateLocationLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-24)
            make.trailing.equalToSuperview().offset(-8)
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
            make.top.equalTo(firstLine.snp.bottom).offset(476)
            make.height.equalTo(1)
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.text = "Description: "
        descriptionLabel.font = UIFont(name: "SF Pro", size: 20)
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
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
        sellerUsername.font = UIFont(name: "SF Pro", size: 12)
        sellerUsername.font = .systemFont(ofSize: 12, weight: .semibold)
        view.addSubview(sellerUsername)
        sellerUsername.snp.makeConstraints { make in
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

    private func setupMakeOfferButton2() {
        makeOfferButton2.setTitle("Make Offer", for: .normal)
        makeOfferButton2.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
        makeOfferButton2.setTitleColor(UIColor.white, for: .normal)
        makeOfferButton2.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        makeOfferButton2.layer.cornerRadius = 20
        //makeOfferButton.addTarget(self, action: #selector(makeOfferButtonTapped), for: .touchUpInside)
        view.addSubview(makeOfferButton2)
        makeOfferButton2.snp.makeConstraints { make in
            make.top.equalTo(contactSellerButton.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(41)
        }
        
        makeOfferButton2.addTarget(self, action: #selector(makeOfferButton2Tapped), for: .touchUpInside)
    }
    
    @objc func makeOfferButton2Tapped() {
        let makeOfferVC = MakeOfferVC(ticket: ticket, event: event)
        self.navigationController?.pushViewController(makeOfferVC, animated: true)
    }

    private func setupSubtotalLabel() {
        subtotalLabel.text = "Subtotal"
        subtotalLabel.font = UIFont(name: "SF Pro", size: 20)
        subtotalLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(subtotalLabel)
        
        subtotalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalTo(secondLine.snp.bottom).offset(20.96)
            make.bottom.equalToSuperview().offset(-138)
            make.height.equalTo(24)
        }
    }

    private func setupDollarLabel() {
        dollarLabel.text = "$"
        dollarLabel.font = UIFont(name: "SF Pro", size: 32)
        dollarLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        view.addSubview(dollarLabel)
        
        dollarLabel.snp.makeConstraints { make in
            make.trailing.equalTo(ticketpriceLabel.snp.leading).offset(-5)
            make.top.equalTo(secondLine.snp.bottom).offset(12.96)
            make.centerY.equalTo(ticketpriceLabel.snp.centerY)
        }
    }
    
    private func setupTicketPriceLabel() {
        ticketpriceLabel.font = UIFont(name: "SF Pro", size: 32)
        ticketpriceLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        ticketpriceLabel.numberOfLines = 1
        view.addSubview(ticketpriceLabel)
        
        ticketpriceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(265)
            make.top.equalTo(secondLine.snp.bottom).offset(12.96)
        }
    }
    
//    private func setupPurchaseButton() {
//        purchaseButton.setTitle("Purchase", for: .normal)
//        purchaseButton.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
//        purchaseButton.setTitleColor(UIColor.white, for: .normal)
//        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//        purchaseButton.layer.cornerRadius = 20
//        view.addSubview(purchaseButton)
//        
//        purchaseButton.snp.makeConstraints { make in
//            make.top.equalTo(profileImage.snp.bottom).offset(40)
//            make.leading.equalToSuperview().offset(18)
//            make.trailing.equalToSuperview().offset(-18)
//            make.height.equalTo(41)
//        }
//    }

    private func setupPurchaseButton() {
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
        purchaseButton.setTitleColor(UIColor.white, for: .normal)
        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        purchaseButton.layer.cornerRadius = 20
        view.addSubview(purchaseButton)
        
        purchaseButton.snp.makeConstraints { make in
            make.top.equalTo(ticketpriceLabel.snp.bottom).offset(27)
            make.bottom.equalToSuperview().offset(-41)
            make.width.equalTo(334)
            make.height.equalTo(41)
            make.centerX.equalToSuperview()
        }
        
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
    }
    
    @objc func purchaseButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "Purchase Successful!", preferredStyle: .alert)
        alertController.view.backgroundColor = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
        alertController.view.layer.cornerRadius = 20
        alertController.view.frame.size = CGSize(width: 231, height: 49)
        alertController.view.frame.origin.y = 240
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            alertController.dismiss(animated: true) {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }


//    @objc func makeOfferButtonTapped() {
//        let makeOfferVC = MakeOfferVC(ticket: Ticket, event: Event)
//        self.navigationController?.pushViewController(makeOfferVC, animated: true)
    
//    }
    
    
}

