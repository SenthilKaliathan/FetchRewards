//
//  MealDetailViewModel.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import Foundation

protocol MealDetailViewModelContract {
    var mealDetailsData: MealDetailModel? { get }
    func setMealDetailsDataDidChangeClosure(callback: @escaping () -> Void) -> Void
    func fetchData(_ category: String?)
}

class MealDetailViewModel: MealDetailViewModelContract {
    
    // MARK: Properties
    var ingredientsArray:[String] = []
    var apiService: WebProviderContract
    
    public var mealDetailsData: MealDetailModel? {
        didSet {
            mealDetailsDataDidChange?()
        }
    }
    
    // MARK: Init
    init(webProvider: WebProviderContract) {
        self.apiService = webProvider
    }
    var onErrorHandling : ((NetworkError) -> Void)?
    private var mealDetailsDataDidChange: (() -> Void)?
    
    func setMealDetailsDataDidChangeClosure(callback: @escaping () -> Void) {
        mealDetailsDataDidChange = callback
    }
    
    func fetchData(_ category: String?) {
        apiService.fetchMealDetails(category ?? "", completion: { result in
            switch result {
            case .failure(let error):
                self.onErrorHandling?(error)
            case .success(let data):
                self.mealDetailsData = data
            }
        })
    }
    
    //  Combine Ingredients and Measurement for UI display and filter out nil elements
    func getIngredientsAndMeasurement() -> [String] {
        
        ingredientsArray.append("\(mealDetailsData?.strIngredient1 ?? "") \(mealDetailsData?.strMeasure1 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient2 ?? "") \(mealDetailsData?.strMeasure2 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient3 ?? "") \(mealDetailsData?.strMeasure3 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient4 ?? "") \(mealDetailsData?.strMeasure4 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient5 ?? "") \(mealDetailsData?.strMeasure5 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient6 ?? "") \(mealDetailsData?.strMeasure6 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient7 ?? "") \(mealDetailsData?.strMeasure7 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient8 ?? "") \(mealDetailsData?.strMeasure8 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient9 ?? "") \(mealDetailsData?.strMeasure9 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient10 ?? "") \(mealDetailsData?.strMeasure10 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient11 ?? "") \(mealDetailsData?.strMeasure11 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient12 ?? "") \(mealDetailsData?.strMeasure12 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient13 ?? "") \(mealDetailsData?.strMeasure13 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient14 ?? "") \(mealDetailsData?.strMeasure14 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient15 ?? "") \(mealDetailsData?.strMeasure15 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient16 ?? "") \(mealDetailsData?.strMeasure16 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient17 ?? "") \(mealDetailsData?.strMeasure17 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient18 ?? "") \(mealDetailsData?.strMeasure18 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient19 ?? "") \(mealDetailsData?.strMeasure19 ?? "")")
        ingredientsArray.append("\(mealDetailsData?.strIngredient20 ?? "") \(mealDetailsData?.strMeasure20 ?? "")")
        // filter nil elements
        ingredientsArray = ingredientsArray.filter { !$0.isEmpty }
        return ingredientsArray
    }
}


