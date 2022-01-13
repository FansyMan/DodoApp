//
//  MenuCollectionViewCell.swift
//  DodoApp
//
//  Created by Surgeont on 14.12.2021.
//

import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MenuCollectionViewCell"
    
    var cathegory: Category!
    var itemsTableView = ItemsTableView()
    var mealsList: [Meal] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(itemsTableView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupCell
    func setupCell(cathegory: Category) {
        let path = cathegory.strCategory
            loadMeals(path: path)
            itemsTableView.meals = self.mealsList
            itemsTableView.reloadData()
    }
    
    // MARK: - Load Meals Func
    private func loadMeals(path: String) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(path)"
        GetMealsManager.shared.getMeals(urlString: urlString) { [weak self] dishes, error in
            if error == nil {
                guard let dishes = dishes else {return}
                let meals = dishes.meals
                self?.mealsList = meals
            } else {
                print(error!)
            }
        }
    }
}

// MARK: - Constraints
extension MenuCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            itemsTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            itemsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            itemsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            itemsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)

        ])
    }
}
