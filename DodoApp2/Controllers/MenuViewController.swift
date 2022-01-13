//
//  MenuViewController.swift
//  DodoApp2
//
//  Created by Surgeont on 15.12.2021.
//

import UIKit

final class MenuViewController: UIViewController {
    
    private let chooseCityButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cathegoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CathegoriesCollectionViewCell.self, forCellWithReuseIdentifier: CathegoriesCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let defaultCity = "Москва"
    private var newsCollectionView = NewsCollectionView()
    var selectedCathegory: Category?
    var cathegoriesList: [Category] = []

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelefgates()
        setConstraints()
        chooseCityButton.setTitle(defaultCity, for: .normal)
        self.loadCategories()
        self.menuCollectionView.reloadData()

    }
    
    // MARK: - Scroll Setup
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == menuCollectionView {
            let cells = menuCollectionView.visibleCells
            if let cell = cells.first, let indexPath = self.menuCollectionView.indexPath(for: cell){
                self.selectedCathegory = self.cathegoriesList[indexPath.row]
                self.cathegoriesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                self.cathegoriesCollectionView.reloadData()
//                self.menuCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - SetupViews / Delegates
    private func setupViews() {
        view.addSubview(chooseCityButton)
        view.addSubview(newsCollectionView)
        view.addSubview(cathegoriesCollectionView)
        view.addSubview(menuCollectionView)
    }
    
    private func setupDelefgates() {
        cathegoriesCollectionView.delegate = self
        cathegoriesCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
    
    // MARK: - Load Cathegories Func
    private func loadCategories() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        GetMealsManager.shared.getCathegories(urlString: urlString) { [weak self] cathegories, error in
            if error == nil {
                guard let cathegories = cathegories else {return}
                let categoryArray = cathegories.categories
                self?.cathegoriesList = categoryArray
                self?.selectedCathegory = categoryArray.first
                self?.cathegoriesCollectionView.reloadData()
                self?.menuCollectionView.reloadData()
            } else {
                print(error!)
            }
        }
    }
}

// MARK: - Constraints
extension MenuViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            chooseCityButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            chooseCityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chooseCityButton.widthAnchor.constraint(equalToConstant: 100),
            chooseCityButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            newsCollectionView.topAnchor.constraint(equalTo: chooseCityButton.bottomAnchor, constant: 10),
            newsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            newsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            newsCollectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        NSLayoutConstraint.activate([
            cathegoriesCollectionView.topAnchor.constraint(equalTo: newsCollectionView.bottomAnchor, constant: 10),
            cathegoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cathegoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cathegoriesCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: cathegoriesCollectionView.bottomAnchor, constant: 10),
            menuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            menuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            menuCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - CollectionView Setups
extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cathegoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         if collectionView == cathegoriesCollectionView {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CathegoriesCollectionViewCell.reuseIdentifier, for: indexPath) as! CathegoriesCollectionViewCell
             let cathegory = cathegoriesList[indexPath.item]
             cell.setupCell(cathegory: cathegory)
             let isSelected = cathegory.strCategory == selectedCathegory?.strCategory
             cell.setupSelection(isSelected: isSelected)
            return cell
         } else {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
             cell.setupCell(cathegory: selectedCathegory!)
            return cell
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cathegoriesCollectionView {
            
            let cathegoryName = cathegoriesList[indexPath.row].strCategory
            let width = cathegoryName.widthOfString(usingFont: UIFont.systemFont(ofSize: 16))
            return CGSize(width: width + 30, height: collectionView.frame.height-15)
            
        } else {
             return CGSize(width: collectionView.frame.width-10, height: collectionView.frame.height-2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    // MARK: - Did Select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cathegoriesCollectionView {
            self.selectedCathegory = cathegoriesList[indexPath.item]
            self.cathegoriesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            cathegoriesCollectionView.reloadData()
            self.menuCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            menuCollectionView.reloadData()
        }
    }
}
