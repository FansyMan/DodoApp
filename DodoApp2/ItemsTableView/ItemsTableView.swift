//
//  ItemsTableView.swift
//  DodoApp
//
//  Created by Surgeont on 14.12.2021.
//

import UIKit

final class ItemsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var meals: [Meal] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        delegate = self
        dataSource = self
        bounces = false
        backgroundColor = .white
        register(ItemsTableViewCell.self, forCellReuseIdentifier: ItemsTableViewCell.reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        self.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TableView Setups
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemsTableViewCell.reuseIdentifier, for: indexPath) as! ItemsTableViewCell
        let meal = meals[indexPath.row]
        cell.setupCell(meal: meal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
