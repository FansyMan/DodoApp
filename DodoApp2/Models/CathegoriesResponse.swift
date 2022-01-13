//
//  File.swift
//  DodoApp2
//
//  Created by Surgeont on 15.12.2021.
//

import Foundation

struct CathegoriesResponse: Decodable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Decodable {
    let strCategory: String
}
