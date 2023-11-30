//
//  EditProfileViewController.swift
//  CUTix
//
//  Created by Maisie Yan on 11/29/23.
//

import Foundation
import UIKit
import SnapKit

protocol UpdateTextDelegate: AnyObject {
    func updateText(usernameText: String, yearText: String, schoolText: String, description: String)
}

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private let usernameLabel = UILabel()
    private let yearLabel = UILabel()
    private let schoolLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let userField = UITextField()
    private let yearField = UITextField()
    private let schoolField = UITextField()
    private let descriptionField = UITextField()
    
    private let saveButton = UIButton()
    
    // MARK: - Properties (data)
    private var usernameText: String = ""
    private var yearText: String = ""
    private var schoolText: String = ""
    private var descriptionText: String = ""
    private weak var delegate: UpdateTextDelegate?
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //setupUsernameTitle()
        setupUsernameField()
        //setupYearTitle()
        setupYearField()
        //setupSchoolTitle()
        setupSchoolField()
        //setupDescriptionTitle()
        setupDescriptionField()
    }
    
    init(username: String, year: String, school: String, description: String, delegate: UpdateTextDelegate) {
        self.usernameText = username
        self.yearText = year
        self.schoolText = school
        self.descriptionText = description
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func configure() {
    }
    
    
    // MARK: - Set Up Views
    
//    private func setupUsernameTitle() {
//        usernameLabel.text = "Username: "
//        usernameLabel.font = UIFont(name: "SF Pro", size: 20)
//        usernameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
//        view.addSubview(usernameLabel)
//
//        usernameLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(28)
//            make.top.equalToSuperview().offset(500)
//        }
//    }
    
    private func setupUsernameField() {
        userField.layer.borderWidth = 1
        userField.layer.borderColor = UIColor.lightGray.cgColor
        userField.layer.cornerRadius = 8
        userField.placeholder = "Username: "
        userField.textAlignment = .left
        
        view.addSubview(userField)
        
        userField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(500)
        }
    }
    
//    private func setupYearTitle() {
//        yearLabel.text = "Year: "
//        yearLabel.font = UIFont(name: "SF Pro", size: 20)
//        yearLabel.font = .systemFont(ofSize: 20, weight: .semibold)
//        view.addSubview(yearLabel)
//
//        yearLabel.snp.makeConstraints { make in
//            make.leading.equalTo(usernameLabel.snp.leading)
//            make.top.equalTo(usernameLabel.snp.bottom).offset(50)
//        }
//    }
    
    private func setupYearField() {
        yearField.layer.borderWidth = 1
        yearField.layer.borderColor = UIColor.lightGray.cgColor
        yearField.layer.cornerRadius = 8
        yearField.placeholder = "Year: "
        yearField.textAlignment = .left
        
        view.addSubview(yearField)
        
        yearField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(500)
        }

    }
    
//    private func setupSchoolTitle() {
//        schoolLabel.text = "School: "
//        schoolLabel.font = UIFont(name: "SF Pro", size: 20)
//        schoolLabel.font = .systemFont(ofSize: 20, weight: .semibold)
//        view.addSubview(schoolLabel)
//
//        schoolLabel.snp.makeConstraints { make in
//            make.leading.equalTo(usernameLabel.snp.leading)
//            make.top.equalTo(yearLabel.snp.bottom).offset(50)
//        }
//    }
    
    private func setupSchoolField() {
        schoolField.layer.borderWidth = 1
        schoolField.layer.borderColor = UIColor.lightGray.cgColor
        schoolField.layer.cornerRadius = 8
        schoolField.placeholder = "School: "
        schoolField.textAlignment = .left
        
        view.addSubview(schoolField)
        
        schoolField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(500)
        }

    }
//
//    private func setupDescriptionTitle() {
//        descriptionLabel.text = "Description: "
//        descriptionLabel.font = UIFont(name: "SF Pro", size: 20)
//        descriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
//        view.addSubview(descriptionLabel)
//
//        descriptionLabel.snp.makeConstraints { make in
//            make.leading.equalTo(usernameLabel.snp.leading)
//            make.top.equalTo(schoolLabel.snp.bottom).offset(50)
//        }
//    }
    
    private func setupDescriptionField() {
        descriptionField.layer.borderWidth = 1
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        descriptionField.layer.cornerRadius = 8
        descriptionField.placeholder = "Description: "
        descriptionField.textAlignment = .left
        
        view.addSubview(descriptionField)
        
        descriptionField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(500)
        }

    }
    
    private func saveProfilePop() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(66)
            make.leading.equalToSuperview().offset(28)
        }
        
        saveButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
    }
  
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
        delegate?.updateText(usernameText: userField.text ?? "", yearText: yearField.text ?? "", schoolText: schoolField.text ?? "", description: descriptionField.text ?? "")
    }

    
}

