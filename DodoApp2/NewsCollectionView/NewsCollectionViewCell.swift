//
//  NewsCollectionViewCell.swift
//  DodoApp
//
//  Created by Surgeont on 13.12.2021.
//

import UIKit

final class NewsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "NewsCollectionViewCell"
    
    let newsImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(newsImageView)
        
        newsImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
    }
}
