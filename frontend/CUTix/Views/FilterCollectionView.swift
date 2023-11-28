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
        self.isSelected = isSelected
        filterTapped()
    }
    
    
    // MARK: - Set Up Views
    
    private func filterTapped() {
        if isSelected {
            filterLabel.backgroundColor = .black
            filterLabel.textColor = .white
        }
        else {
            filterLabel.textColor = .black
            filterLabel.backgroundColor = .lightGray
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


