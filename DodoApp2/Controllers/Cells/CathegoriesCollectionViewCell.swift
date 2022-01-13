//
//  CathegoriesCollectionViewCell.swift
//  DodoApp
//
//  Created by Surgeont on 13.12.2021.
//

import UIKit

final class CathegoriesCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CathegoriesCollectionViewCell"
        
    let cathegoryLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.layer.frame.height/2
        self.addSubview(cathegoryLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cathegoryLabel.text = nil
    }
    
    func setupSelection(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = .systemPink
            self.cathegoryLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        } else {
            self.backgroundColor = .white
            self.cathegoryLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    // MARK: - SetupCell
    func setupCell(cathegory: Category) {
        self.cathegoryLabel.text = cathegory.strCategory
    }
    
}

// MARK: - Constraints
extension CathegoriesCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cathegoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cathegoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cathegoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
