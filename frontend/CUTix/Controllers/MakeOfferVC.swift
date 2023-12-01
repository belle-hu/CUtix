//
//  MakeOfferVC.swift
//  CUTix
//
//  Created by Rica Craig on 11/30/23.
//

import Foundation
import UIKit
import SnapKit

class MakeOfferVC: UIViewController {
    
    
    // MARK: - Properties (view)
    private let nameLabel = UILabel()
    private let dateLocationLabel = UILabel()
    private let offerfirstLine = UILabel()
    private let offersecondLine = UILabel()
    private let offerthirdLine = UILabel()
    private let originalPriceLabel = UILabel()
    private let originalPriceField = UILabel()
    private let offerPriceLabel = UILabel()
    private let offerPriceField = UILabel()
    private let makeOfferButton = UIButton()
    
    weak var TicketInfoVC: TicketInfoVC?
    
    // MARK: - Properties (data)
    private var ticket: Ticket
    private var event: Event
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupName()
        setupDateLocation()
        setupOfferFirstLine()
        setupOfferSecondLine()
//        setupOriginalPriceLabel()
//        setupOfferThirdLine()
//        setupOriginalPriceField()
//        setupOfferPriceLabel()
//////        setupOfferPriceField()
////        setupMakeOfferButton()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
        
    init(ticket: Ticket, event: Event) {
        self.ticket = ticket
        nameLabel.text = event.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        dateLocationLabel.text = dateFormatter.string(from: event.time) + " - " + event.location
        self.event = event
        originalPriceField.text = String(ticket.cost)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    
    // MARK: - Set Up Views
    
    private func setupName() {
        nameLabel.font = UIFont(name: "SF Pro", size: 24)
        nameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.top.equalToSuperview().offset(100)
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
    
    private func setupOfferFirstLine() {
        offerfirstLine.backgroundColor = .black
        view.addSubview(offerfirstLine)
        
        offerfirstLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            //make.top.equalTo(dateLocationLabel.snp.top).offset(236)
            make.bottom.equalToSuperview().offset(-574.96)
            make.height.equalTo(1)
        }
    }
    
    private func setupOfferSecondLine() {
        offersecondLine.backgroundColor = .black
        view.addSubview(offersecondLine)
        
        offersecondLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            //make.top.equalTo(offerfirstLine.snp.bottom).offset(-499.96)
            make.bottom.equalToSuperview().offset(-499.96)
            make.height.equalTo(1)
        }
    }
    
    func setupOriginalPriceLabel() {
        originalPriceLabel.font = UIFont(name: "SF Pro", size: 10)
        originalPriceLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        originalPriceLabel.numberOfLines = 0
        
        view.addSubview(originalPriceLabel)
        
        originalPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLocationLabel.snp.leading)
            make.top.equalTo(offerfirstLine.snp.bottom).offset(-25.96)
            make.bottom.equalTo(offersecondLine.snp.top).offset(19)
            make.height.equalTo(29)
        }
    }

    private func setupOfferThirdLine() {
        offerthirdLine.backgroundColor = .black
        view.addSubview(offerthirdLine)
        
        offerthirdLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            //make.top.equalTo(offerfirstLine.snp.bottom).offset(-148.96)
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-424.96)
        }
    }
    
    func setupOriginalPriceField() {
        originalPriceField.font = UIFont(name: "SF Pro", size: 32)
        originalPriceField.font = .systemFont(ofSize: 32, weight: .semibold)
        originalPriceField.numberOfLines = 0
        view.addSubview(originalPriceField)
        
        originalPriceField.snp.makeConstraints { make in
            make.top.equalTo(offerfirstLine.snp.bottom).offset(6.96)
            make.bottom.equalTo(offersecondLine.snp.top).offset(-8)
            make.trailing.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(-266)
            make.height.equalTo(59)
        }
    }
    
    func setupOfferPriceLabel() {
        offerPriceLabel.font = UIFont(name: "SF Pro", size: 20)
        offerPriceLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        offerPriceLabel.numberOfLines = 0
        view.addSubview(offerPriceLabel)
        
        offerPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(offersecondLine.snp.bottom).offset(25.96)
            make.bottom.equalTo(offerthirdLine.snp.top).offset(-19)
            make.leading.equalToSuperview().offset(18)
            make.height.equalTo(29)
        }
    }
    
    func setupOfferPriceField() {
        offerPriceField.font = UIFont(name: "SF Pro", size: 32)
        offerPriceField.font = .systemFont(ofSize: 32, weight: .semibold)
        offerPriceField.numberOfLines = 0
        view.addSubview(originalPriceField)
        
        offerPriceField.snp.makeConstraints { make in
            make.top.equalTo(offersecondLine.snp.bottom).offset(-6.96)
            make.bottom.equalTo(offerthirdLine.snp.top).offset(8)
            make.leading.equalToSuperview().offset(220)
            make.height.equalTo(59)
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
            make.top.equalTo(offerthirdLine.snp.bottom).offset(48.96)
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-335)
        }
    }
    
    
//    func setupOfferPriceTextField() {
//        offerPriceTextField.placeholder = "Enter your offer"
//        offerPriceTextField.keyboardType = .decimalPad
//        offerPriceTextField.delegate = self
//        self.view.addSubview(offerPriceTextField)
//        
//        offerPriceTextField.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalTo(dateLocationLabel.snp.bottom).offset(25)
//            make.height.equalTo(1)
//        }
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == offerPriceField {
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            if let number = Double(newText), let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) {
                offerPriceLabel.text = "\(formattedNumber)"
            }
            return true
        }
        return false
    }
        
    
    //    func setupNameLabel() {
    //        nameLabel.text = ticket?.id
    //        self.view.addSubview(nameLabel)
    //        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
    //            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
    //        ])
    //    }
    //
    //    func setupDateLabel() {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    //        let date = dateFormatter.date(from: ticket?.time ?? "")
    //        dateFormatter.dateFormat = "MMM dd, yyyy 'at' h:mm a"
    //        let dateString = dateFormatter.string(from: date ?? Date())
    //
    //        dateLabel.text = dateString
    //        self.view.addSubview(dateLabel)
    //        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
    //            dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
    //        ])
    //    }
    //
    //    func setupLocationLabel() {
    //        locationLabel.text = ticket?.location
    //        self.view.addSubview(locationLabel)
    //        locationLabel.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
    //            locationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
    //        ])
    //    }
    //
    //
    //    func setupMakeOfferButton() {
    //        let makeOfferButton = UIButton()
    //        makeOfferButton.setTitle("Make Offer", for: .normal)
    //        makeOfferButton.setTitleColor(.blue, for: .normal)
    //        self.view.addSubview(makeOfferButton)
    //        makeOfferButton.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            makeOfferButton.topAnchor.constraint(equalTo: offerPriceLabel.bottomAnchor, constant: 20),
    //            makeOfferButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    //        ])
    //    }
    
        @objc func backButtonTapped() {
            if let TicketInfoVC = TicketInfoVC {
                self.navigationController?.popToViewController(TicketInfoVC, animated: true)
            }
        }
    //}
    //
    ////    @objc func backButtonTapped() {
    ////        self.navigationController?.popToRootViewController(animated: true)
    ////    }
    //
    //
    //
    //
    //
    //
}
