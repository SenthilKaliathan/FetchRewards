//
//  APIService.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import Foundation

struct URLEndPoints {
    static let categoriesURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
    static let mealsURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    static let mealDetailsURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    static let malformedURL = "https://www.themealdb.com/api/json/v1/1/filter.php?csd="
}

protocol WebProviderContract {
    func fetchCategories(completion: @escaping (Swift.Result<[Categories], NetworkError>) -> Void)
    func fetchSubCategories(_ queryString: String, completion: @escaping (Swift.Result<[MealModel], NetworkError>) -> Void)
    func fetchMealDetails(_ queryString: String, completion: @escaping (Swift.Result<MealDetailModel?, NetworkError>) -> Void)
}

// Network wrapper to make network calls.
final class APIService: WebProviderContract {
    
    private let networkManager = NetworkManager()
    
    // MARK: Fetch list of categories
    func fetchCategories(completion: @escaping (Swift.Result<[Categories], NetworkError>) -> Void) {
        
        guard let url = URL(string: URLEndPoints.categoriesURL) else {
            completion(.failure(.invalidURL))
            return
        }
        let requestHeader = ["Content-Type": "application/json"]
        networkManager.sendRequest(url: url, requestType: .get, header: requestHeader) {
            (response) in
            switch response {
            case .success(let data):
                if let safeData = data {
                    do {
                        let dataModel = try JSONDecoder().decode(CategoriesModel.self, from: safeData)
                        // Handle empty JSON
                        if (dataModel.categories?.count == 0) {
                            completion(.failure(.nullData))
                        } else {
                            completion(.success(dataModel.categories ?? []))
                        }
                    }
                    catch {
                        completion(.failure(.invalidJSON))
                    }
                }
            case .failure:
                completion(.failure(.badStatus))
            }
          
        }
    }
    
    
    // MARK: Fetch meal sub categories
    func fetchSubCategories(_ queryString: String, completion: @escaping (Swift.Result<[MealModel], NetworkError>) -> Void) {
        
        let url = String(format: "%@%@", URLEndPoints.mealsURL, queryString)
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        let requestHeader = ["Content-Type": "application/json"]
        networkManager.sendRequest(url: url, requestType: .get, header: requestHeader) {
            (response) in
            switch response {
            case .success(let data):
                if let safeData = data {
                    do {
                        let dataModel = try JSONDecoder().decode(MealsModel.self, from: safeData)
                        // Handle empty JSON
                        if (dataModel.meals?.count == 0) {
                            completion(.failure(.nullData))
                        } else {
                            completion(.success(dataModel.meals ?? []))
                        }
                    } catch {
                        completion(.failure(.invalidJSON))
                    }
                }
            case .failure:
                completion(.failure(.badStatus))
            }
        }
    }
    
    // MARK: Fetech meal details
    func fetchMealDetails(_ queryString: String, completion: @escaping (Result<MealDetailModel?, NetworkError>) -> Void) {
        
        let url = String(format: "%@%@", URLEndPoints.mealDetailsURL, queryString)
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        let requestHeader = ["Content-Type": "application/json"]
        networkManager.sendRequest(url: url, requestType: .get, header: requestHeader) {
            (response) in
            switch response {
            case .success(let data):
                if let safeData = data {
                    do {
                        let dataModel = try JSONDecoder().decode(MealDetails.self, from: safeData)
                        // Handle empty JSON
                        if (dataModel.meals?.count == 0) {
                            completion(.failure(.nullData))
                        } else {
                            completion(.success(dataModel.meals?[0]))
                        }
                    } catch {
                        completion(.failure(.invalidJSON))
                    }
                }
            case .failure:
                completion(.failure(.badStatus))
                
            }
        }
    }
    
}
