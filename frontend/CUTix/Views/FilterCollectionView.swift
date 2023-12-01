//
//  FilterCollectionView.swift
//  CUTix
//
//  Created by Maisie Yan on 11/19/23.
//

import Foundation
import UIKit
import SnapKit


protocol FilterCollectionViewDelegate: AnyObject {
    func selectedFilter(index: Int)
}

class FilterCollectionView: UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    private let filterLabel = UILabel()
    static let reuse = "FilterCollectionViewReuse"
    weak var delegate: FilterCollectionViewDelegate?
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFilter))
        setupFilterLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    
    func configure(filter: String, isSelected: Bool) {
        filterLabel.text = filter
        filterLabel.font = UIFont(name: "SF Pro", size: 16)
        filterLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        self.isSelected = isSelected
        filterTapped()
    }
    
    
    // MARK: - Set Up Views
    
    private func filterTapped() {
        if isSelected {
            filterLabel.backgroundColor = UIColor(red: 0.7, green: 0.11, blue: 0.11, alpha: 1)
            filterLabel.textColor = .white
        }
        else {
            filterLabel.textColor = .black
            filterLabel.backgroundColor = .white
            filterLabel.layer.borderWidth = 1.0
            filterLabel.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    private func setupFilterLabel() {
        filterLabel.textAlignment = .center
        filterLabel.layer.cornerRadius = 16
        filterLabel.layer.masksToBounds = true
        
        contentView.addSubview(filterLabel)
        
        filterLabel.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(116)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    @objc private func tapFilter() {
        isSelected.toggle()
        filterTapped()
        delegate?.selectedFilter(index: tag)
    }
    
}


