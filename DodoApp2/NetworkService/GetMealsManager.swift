//
//  GetMealsManager.swift
//  DodoApp2
//
//  Created by Surgeont on 15.12.2021.
//

import Foundation

class GetMealsManager {
    
    static let shared = GetMealsManager()
    private init() {
    }
    
    func getCathegories(urlString: String, response: @escaping (CathegoriesResponse?, Error?) -> Void) {
        NetworkService.shared.getData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let cathegories = try JSONDecoder().decode(CathegoriesResponse.self, from: data)
                    response(cathegories, nil)
                } catch let responseError {
                    print("Wrong in decoding \(responseError.localizedDescription)")
                }
            case .failure(let error):
                print("Wrong in Search Service \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
    
    func getMeals(urlString: String, response: @escaping (DishesResponse?, Error?) -> Void) {
        NetworkService.shared.getData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let dishes = try JSONDecoder().decode(DishesResponse.self, from: data)
                    response(dishes, nil)
                } catch let responseError {
                    print("Wrong in decoding \(responseError.localizedDescription)")
                }
            case .failure(let error):
                print("Wrong in Search Service \(error.localizedDescription)")
                response(nil, error)
            }
        }
    }
}
