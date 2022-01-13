//
//  MainTapBarController.swift
//  DodoApp2
//
//  Created by Surgeont on 15.12.2021.
//

import UIKit

final class MainTapBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTapBar()
    }
    
    private func setupTapBar() {
        
        let menuVC = createController(vc: MenuViewController(), itemName: "Меню", imageName: "airplane")
        // Остальный контроллеры пустые и лежат в отдельной папке
        let contactsVC = createController(vc: MenuViewController(), itemName: "Контакты", imageName: "car.fill")
        let profileVC = createController(vc: MenuViewController(), itemName: "Профиль", imageName: "person.fill")
        let chartVC = createController(vc: MenuViewController(), itemName: "Корзина", imageName: "cart.fill")
        
        viewControllers = [menuVC, contactsVC, profileVC, chartVC]
    }
    
    private func createController(vc: UIViewController, itemName: String, imageName: String) -> UIViewController {
        
        // Немного подровнять отображение иконок
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: imageName)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let viewController = vc
        vc.tabBarItem = item
        return viewController
    }
    
}
