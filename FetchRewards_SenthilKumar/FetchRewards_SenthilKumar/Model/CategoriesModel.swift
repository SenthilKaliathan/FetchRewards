//
//  CategoriesModel.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import Foundation

struct CategoriesModel: Codable {
    let categories: [Categories]?
}

// MARK: Category Data Model
struct Categories: Codable  {
    let idCategory: String?
    let strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
    
    var thumbImageUrl: URL? {
        return URL(string: strCategoryThumb ?? "")
    }
}
