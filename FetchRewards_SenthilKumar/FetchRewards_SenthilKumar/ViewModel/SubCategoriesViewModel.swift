//
//  SubCategoriesViewModel.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import Foundation

protocol SubCategoriesViewModelContract {
    var subCategoriesData: [MealModel] { get }
    func fetchData(_ category: String?)
}

class SubCategoriesViewModel: SubCategoriesViewModelContract {
    
    // MARK: Properties
    var apiService:WebProviderContract
    
    public var subCategoriesData: [MealModel] = []
    var onErrorHandling: ((NetworkError) -> Void)?
    var successData: (() -> Void)?
    
    // MARK: Init
    init(webProvider: WebProviderContract) {
        self.apiService = webProvider
    }
    
    func fetchData(_ category: String?) {
        apiService.fetchSubCategories (category ?? "", completion: { result in
            switch result {
            case .failure(let error):
                self.onErrorHandling?(error)
            case .success(let data):
                self.subCategoriesData.removeAll()
                // Sort data and assign
                self.subCategoriesData = data.sorted(by: { $0.strMeal?.lowercased() ?? "" < $1.strMeal?.lowercased() ?? "" })
                self.successData?()
            }
        })
    }
    
}
