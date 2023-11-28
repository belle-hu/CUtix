//
//  TagFilterCell.swift
//  CUTix
//
//  Created by Rica Craig on 11/26/23.
//

import UIKit

class TagFilterCell: UICollectionViewCell {
    
    var filterView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        filterView = UILabel()
        filterView.layer.borderWidth = 1
        filterView.layer.borderColor = UIColor.lightGray.cgColor
        filterView.layer.cornerRadius = 10
        filterView.textColor = UIColor.lightGray
        filterView.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        filterView.textAlignment = .center
        contentView.addSubview(filterView)
        
        isSelected = false
        
        setUpConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraint() {
        filterView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
    }
    
    func configure(for filter: String) {
        filterView.text = filter
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            if isSelected {
                filterView.layer.borderColor = UIColor(red: 0.702, green: 0.106, blue: 0.106, alpha: 1).cgColor
                filterView.textColor = UIColor(red: 0.702, green: 0.106, blue: 0.106, alpha: 1)
            } else {
                filterView.layer.borderColor = UIColor.lightGray.cgColor
                filterView.textColor = UIColor.lightGray
            }
            setNeedsDisplay()
        }
    }
    
    func selected() {
        filterView.textColor = UIColor(red: 0.702, green: 0.106, blue: 0.106, alpha: 1)
        filterView.layer.borderColor = UIColor(red: 0.702, green: 0.106, blue: 0.106, alpha: 1).cgColor
    }
    
    func deselected() {
        filterView.layer.borderColor = UIColor.lightGray.cgColor
        filterView.textColor = UIColor.lightGray
    }
}

//"UIColor(red: 0.702, green: 0.106, blue: 0.106, alpha: 1)" corresponds to Cornell Red color in Figma.
