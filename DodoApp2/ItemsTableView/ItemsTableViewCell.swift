//
//  ItemsTableViewCell.swift
//  DodoApp
//
//  Created by Surgeont on 14.12.2021.
//
import UIKit


final class ItemsTableViewCell:  UITableViewCell {
    
    static let reuseIdentifier = "ItemsTableViewCell"
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mealName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder")
    }
    
    // MARK: - SetupCell
    func setupCell(meal: Meal) {
        mealName.text = meal.strMeal
        priceButton.setTitle("Заказать", for: .normal)
        let urlString = meal.strMealThumb
        let url = URL(string: urlString)!
        LoadAndCashImages.shared.itemloadImage(url: url) { image in
            self.productImage.image = image
        }
    }
    
    // MARK: - SetupViews
    private func setupViews() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        self.addSubview(productImage)
        self.addSubview(mealName)
        self.addSubview(priceButton)
    }
}

// MARK: - Constraints
extension ItemsTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            productImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            productImage.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            mealName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mealName.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10),
            mealName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            priceButton.topAnchor.constraint(equalTo: mealName.bottomAnchor, constant: 10),
            priceButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            priceButton.widthAnchor.constraint(equalToConstant: 100),
            priceButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
