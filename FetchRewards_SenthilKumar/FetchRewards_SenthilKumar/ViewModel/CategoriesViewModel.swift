//
//  CategoriesViewModel.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import Foundation

protocol CategoriesViewModelContract {
    var categoriesData: [Categories] { get }
    func setcategoriesDataDidChangeClosure(callback: @escaping () -> Void) -> Void
    func fetchData()
}

class CategoriesViewModel: CategoriesViewModelContract {
    
    // MARK: Properties
    var apiService:WebProviderContract
    
    public var categoriesData: [Categories] = [] {
        didSet {
            // Sort the data alphatecially
            categoriesData = categoriesData.sorted(by: { $0.strCategory?.lowercased() ?? "" < $1.strCategory?.lowercased() ?? "" })
            categoriesDataDidChange?()
        }
    }
    var onErrorHandling : ((NetworkError) -> Void)?
    private var categoriesDataDidChange: (() -> Void)?
    
    // MARK: Init
    init(webProvider: WebProviderContract) {
        self.apiService = webProvider
    }
    
    func setcategoriesDataDidChangeClosure(callback: @escaping () -> Void) {
        categoriesDataDidChange = callback
    }
    
    func fetchData() {
        
        apiService.fetchCategories { result in
            switch result {
            case .failure(let error):
                print("An error occured ", error)
                self.onErrorHandling?(error)
            case .success(let data):
                self.categoriesData = data
            }
        }
    }
    
}
