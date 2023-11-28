//
//  OfferScreen1.swift
//  CUTix
//
//  Created by Rica Craig on 11/25/23.
//

import UIKit

class OfferScreen1: UIViewController {
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if self.isMovingFromParent {
//            for controller in self.navigationController!.viewControllers as Array {
//                if controller.isKind(of: NewTicket.self) {
//                    self.navigationController?.popToViewController(controller, animated: true)
//                    break
//                }
//            }
//        }
//    }
    
    let titleLabel = UILabel()
    let originalPriceLabel = UILabel()
    let currentPriceLabel = UILabel()
    let dollarLabel = UILabel()
    let offerTextField = UITextField()
    
    var ticket: Flow3TestTicket
    
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
        
        setupTitleLabel()
        setupOriginalPriceLabel()
        setupCurrentPriceLabel()
        setupDollarLabel()
        setupOfferTextField()
        setupContinueButton()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
//        let ticket = dummyData.first!
//        let editProfileVC = OfferScreen1(ticket: ticket)
//        self.navigationController?.pushViewController(editProfileVC, animated: true)
        
        let offerScreen2 = OfferScreen2(ticket: ticket)
        offerScreen2.offerScreen1 = self
        self.navigationController?.pushViewController(offerScreen2, animated: true)
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backButtonTapped))
        
    }

    func setupTitleLabel() {
        titleLabel.text = "Make an Offer"
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 77),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }

    func setupOriginalPriceLabel() {
        originalPriceLabel.text = "Price: \(ticket.price ?? "")"
        originalPriceLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.view.addSubview(originalPriceLabel)
        originalPriceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            originalPriceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            originalPriceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 122)
        ])
    }
    
    func setupCurrentPriceLabel() {
        currentPriceLabel.text = "Your Offer:"
        currentPriceLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        self.view.addSubview(currentPriceLabel)
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            currentPriceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 103),
            currentPriceLabel.topAnchor.constraint(equalTo: originalPriceLabel.bottomAnchor, constant: 41),
        ])
    }
    
    func setupDollarLabel() {
        dollarLabel.text = "$"
        dollarLabel.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        self.view.addSubview(dollarLabel)
        dollarLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dollarLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 10),
            dollarLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 110)
        ])
    }

    func setupOfferTextField() {
        offerTextField.placeholder = "XX.XX"
        offerTextField.font = UIFont.systemFont(ofSize: 40)
        self.view.addSubview(offerTextField)
        offerTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            offerTextField.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 20),
            offerTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    func setupContinueButton() {
        let continueButton = UIButton()
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.blue, for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        self.view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: offerTextField.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
//    @objc func continueButtonTapped() {
//        let profileVC = OfferScreen2(ticket: ticket)
//        profileVC.offerPrice = offerTextField.text
//        self.navigationController?.pushViewController(profileVC, animated: true)
//    }
    
    @objc func continueButtonTapped() {
        let offerScreen2 = OfferScreen2(ticket: ticket)
        offerScreen2.offerPrice = offerTextField.text
        self.navigationController?.pushViewController(offerScreen2, animated: true)
    }
}


