//
//  OfferScreen2.swift
//  CUTix
//
//  Created by Rica Craig on 11/25/23.
//

import UIKit

class OfferScreen2: UIViewController {
    var offerPrice: String?
    var ticket: Flow3TestTicket?
    
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let locationLabel = UILabel()
    let originalPriceLabel = UILabel()
    let offerPriceLabel = UILabel()
    
    weak var offerScreen1: OfferScreen1?
    
    init(ticket: Flow3TestTicket) {
        self.ticket = ticket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupNameLabel()
        setupDateLabel()
        setupLocationLabel()
        setupOriginalPriceLabel()
        setupOfferPriceLabel()
        setupMakeOfferButton()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    func setupNameLabel() {
        nameLabel.text = ticket?.id
        self.view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: ticket?.time ?? "")
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' h:mm a"
        let dateString = dateFormatter.string(from: date ?? Date())
        
        dateLabel.text = dateString
        self.view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupLocationLabel() {
        locationLabel.text = ticket?.location
        self.view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupOriginalPriceLabel() {
        originalPriceLabel.text = "Original Price: \(ticket?.price ?? "")"
        self.view.addSubview(originalPriceLabel)
        originalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            originalPriceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            originalPriceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupOfferPriceLabel() {
        offerPriceLabel.text = "Offer Price: \(offerPrice ?? "")"
        self.view.addSubview(offerPriceLabel)
        offerPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            offerPriceLabel.topAnchor.constraint(equalTo: originalPriceLabel.bottomAnchor, constant: 20),
            offerPriceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        ])
    }
    
    func setupMakeOfferButton() {
        let makeOfferButton = UIButton()
        makeOfferButton.setTitle("Make Offer", for: .normal)
        makeOfferButton.setTitleColor(.blue, for: .normal)
        self.view.addSubview(makeOfferButton)
        makeOfferButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            makeOfferButton.topAnchor.constraint(equalTo: offerPriceLabel.bottomAnchor, constant: 20),
            makeOfferButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc func backButtonTapped() {
        if let offerScreen1 = offerScreen1 {
            self.navigationController?.popToViewController(offerScreen1, animated: true)
        }
    }
}

//    @objc func backButtonTapped() {
//        self.navigationController?.popToRootViewController(animated: true)
//    }
    




