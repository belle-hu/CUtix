//
//  ProfileViewController.swift
//  CUTix
//
//  Created by Maisie Yan on 11/28/23.
//

import Foundation
import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties (view)
    private let usernameLabel = UILabel()
    private let yearLabel = UILabel()
    private let schoolLabel = UILabel()
    private let majorLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let yourTicketsLabel = UILabel()
    private let profileImage = UIImageView()
    private let yearSchoolLabel = UILabel()
    private let editProfileButton = UIButton()
    
    // MARK: - Properties (data)
    
    var usernameTextDelegate = "Username"
    var yearTextDelegate = "Year"
    var schoolTextDelegate = "School"
    var majorTextDelegate = "Major"
    var descriptionTextDelegate = "Description:"
    
    // MARK: - viewDidLoad and init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupProfileImage()
        setupUsername()
        setupYearSchool()
        setupMajor()
        setupDescription()
        setupYourTicketsLabel()
        setupEditProfileButton()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func configure() {
    }
    
    
    // MARK: - Set Up Views
    
    private func setupUsername() {
        usernameLabel.text = usernameTextDelegate
        usernameLabel.font = UIFont(name: "SF Pro", size: 32)
        usernameLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        view.addSubview(usernameLabel)
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalTo(profileImage.snp.trailing).offset(18)
        }
    }
    
    private func setupYearSchool() {
        yearSchoolLabel.text = yearTextDelegate + " | " + schoolTextDelegate
        yearSchoolLabel.font = UIFont(name: "SF Pro", size: 16)
        view.addSubview(yearSchoolLabel)
        
        yearSchoolLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
        }
    }
    
    private func setupMajor() {
        majorLabel.text = majorTextDelegate
        majorLabel.font = UIFont(name: "SF Pro", size: 16)
        view.addSubview(majorLabel)
        
        majorLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(yearSchoolLabel.snp.bottom).offset(3)
        }
    }
    
    private func setupDescription() {
        descriptionLabel.text = descriptionTextDelegate
        descriptionLabel.font = UIFont(name: "SF Pro", size: 16)
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(majorLabel.snp.bottom).offset(3)
        }
    }
    
    private func setupProfileImage() {
        profileImage.image = UIImage(named: "offerPfp")
        view.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(27)
            make.top.equalToSuperview().offset(128)
            make.size.equalTo(100)
        }
    }
    
    private func setupYourTicketsLabel() {
        yourTicketsLabel.text = "Your Tickets"
        yourTicketsLabel.font = UIFont(name: "SF Pro", size: 32)
        yourTicketsLabel.font = .systemFont(ofSize: 32, weight: .semibold)
        view.addSubview(yourTicketsLabel)
        
        yourTicketsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(profileImage.snp.bottom).offset(63)
        }
    }
    
    private func setupEditProfileButton() {
        editProfileButton.setImage(UIImage(named: "pencil"), for: .normal)
        view.addSubview(editProfileButton)
        
        editProfileButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(130)
        }
        
        editProfileButton.addTarget(self, action: #selector(pushEditButton), for: .touchUpInside)
    }
    
    @objc private func pushEditButton() {
        let editProfileVC = EditProfileViewController(username: usernameTextDelegate, year: yearTextDelegate, school: schoolTextDelegate, description: descriptionTextDelegate, delegate: self)
        
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

}

extension ProfileViewController: UpdateTextDelegate {
    func updateText(usernameText: String, yearText: String, schoolText: String, description: String) {
        usernameTextDelegate = usernameText
        yearTextDelegate = yearText
        schoolTextDelegate = schoolText
        descriptionTextDelegate = description
        usernameLabel.text = usernameText
        yearLabel.text = yearText
        schoolLabel.text = schoolText
        descriptionLabel.text = description
    }
}
