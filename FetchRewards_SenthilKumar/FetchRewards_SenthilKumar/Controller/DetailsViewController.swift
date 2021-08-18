//
//  DetailsViewController.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var ingredientsStackView: UIStackView!
    private var ingredientsLabel: UILabel!
    var selectedDetailsId: String!
    let viewModel = MealDetailViewModel(webProvider: APIService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Steps to prepare!"
        self.viewModel.onErrorHandling = { error in
            self.displayError(error)
        }
        viewModel.fetchData(selectedDetailsId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadView()
    }
    
    // MARK: Display Error
    private func displayError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.name.text = ""
            self.detailDescription.text = ""
            ErrorUtility.showError(error, viewController: self)
        }
    }
    
    
    private func reloadView() {
        self.viewModel.setMealDetailsDataDidChangeClosure {
            DispatchQueue.main.async { [self] in
                
                if let mealName = self.viewModel.mealDetailsData?.strMeal {
                    self.name.text = mealName
                } else {
                    self.name.text = ""
                }
                self.detailDescription.text = self.viewModel.mealDetailsData?.strInstructions ?? ""
                self.updateIngredients(viewModel.getIngredientsAndMeasurement())
                self.view.setNeedsLayout()
            }
        }
    }
    
    // MARK: Create label and add to stack view based on data count
    private func updateIngredients(_ dataArray: [String]) {
        for element in dataArray {
            ingredientsLabel = UILabel()
            ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
            ingredientsLabel.numberOfLines = 0
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
            ingredientsLabel.text = element
            // Add label to stack view
            ingredientsStackView.addArrangedSubview(ingredientsLabel)
        }
    }
    
}
