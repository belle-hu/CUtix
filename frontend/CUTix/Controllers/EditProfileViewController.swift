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
    func updateText(usernameText: String, yearText: String, schoolText: String, majorText: String, description: String)
}

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private let usernameLabel = UILabel()
    private let yearLabel = UILabel()
    private let schoolLabel = UILabel()
    private let majorLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let editProfileTitle = UILabel()
    
    private let profileImage = UIImageView()
    
    private let userField = UITextField()
    private let yearField = UITextField()
    private let schoolField = UITextField()
    private let majorField = UITextField()
    private let descriptionField = UITextField()
    
    private let saveButton = UIButton()
    
    // MARK: - Properties (data)
    private var usernameText: String = ""
    private var yearText: String = ""
    private var schoolText: String = ""
    private var majorText: String = ""
    private var descriptionText: String = ""
    private weak var delegate: UpdateTextDelegate?
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupEditProfileTitle()
        setupProfileImage()
        setupUsernameField()
        setupYearField()
        setupSchoolField()
        setupMajorField()
        setupDescriptionField()
        saveProfilePop()
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
    
    private func setupEditProfileTitle() {
        editProfileTitle.text = "Edit Profile"
        editProfileTitle.font = UIFont(name: "SF Pro", size: 32)
        editProfileTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        view.addSubview(editProfileTitle)
        
        editProfileTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(300)
        }
    }
    
    private func setupProfileImage() {
        profileImage.image = UIImage(named: "offerPfp")
        view.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(175)
            make.size.equalTo(100)
        }
    }
    
    private func setupUsernameField() {
        userField.layer.borderWidth = 1
        userField.layer.borderColor = UIColor.lightGray.cgColor
        userField.layer.cornerRadius = 8
        userField.placeholder = "   Username: "
        userField.textAlignment = .center
        
        view.addSubview(userField)
        
        userField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(400)
        }
    }
    
    private func setupYearField() {
        yearField.layer.borderWidth = 1
        yearField.layer.borderColor = UIColor.lightGray.cgColor
        yearField.layer.cornerRadius = 8
        yearField.placeholder = "   Year: "
        yearField.textAlignment = .center
        
        view.addSubview(yearField)
        
        yearField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalTo(userField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(40)
        }

    }
    
    private func setupSchoolField() {
        schoolField.layer.borderWidth = 1
        schoolField.layer.borderColor = UIColor.lightGray.cgColor
        schoolField.layer.cornerRadius = 8
        schoolField.placeholder = "   School: "
        schoolField.textAlignment = .center
        
        view.addSubview(schoolField)
        
        schoolField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalTo(yearField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(40)
        }
    }
    
    private func setupMajorField() {
        majorField.layer.borderWidth = 1
        majorField.layer.borderColor = UIColor.lightGray.cgColor
        majorField.layer.cornerRadius = 8
        majorField.placeholder = "   Major: "
        majorField.textAlignment = .center
        
        view.addSubview(majorField)
        
        majorField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalTo(schoolField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(40)
        }
    }
    
    private func setupDescriptionField() {
        descriptionField.layer.borderWidth = 1
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        descriptionField.layer.cornerRadius = 8
        descriptionField.placeholder = "   Description: "
        descriptionField.textAlignment = .center
        
        view.addSubview(descriptionField)
        
        descriptionField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalTo(majorField.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(40)
        }

    }
    
    private func saveProfilePop() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(28)
        }
        
        saveButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
    }
  
    @objc private func popVC() {
        navigationController?.popViewController(animated: true)
        delegate?.updateText(usernameText: userField.text ?? "", yearText: yearField.text ?? "", schoolText: schoolField.text ?? "", majorText: majorField.text ?? "", description: descriptionField.text ?? "")
    }

    
}

