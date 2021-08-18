//
//  SubCategoriesViewController.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import UIKit

class SubCategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SubCategoriesViewModel(webProvider: APIService())
    private let cellIdentifier = "SubCategoriesTableViewCell"
    private let seagueIdentifer = "detailsVC"
    var subCategoryName = ""
    var selectedDetailsId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choose your Yummy " + subCategoryName
        self.viewModel.onErrorHandling = { error in
            self.displayError(error: error)
        }
        viewModel.fetchData(subCategoryName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableView()
    }
    
    private func displayError(error: NetworkError) {
        ErrorUtility.showError(error, viewController: self)
    }
    
    private func reloadTableView() {
        self.viewModel.successData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: Tableview delegate, datasource
extension SubCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SubCategoriesTableViewCell else { return UITableViewCell() }
        let dataModel = viewModel.subCategoriesData[indexPath.row]
        cell.configureCell(dataModel: dataModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.subCategoriesData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataModel = viewModel.subCategoriesData[indexPath.row]
        if let strCategory = dataModel.idMeal {
            selectedDetailsId = strCategory
            self.performSegue(withIdentifier: seagueIdentifer, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seagueIdentifer {
            if let viewController = segue.destination as? DetailsViewController {
                viewController.selectedDetailsId = selectedDetailsId
            }
        }
    }
    
}

