//
//  ViewController.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import UIKit
import Foundation

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = CategoriesViewModel(webProvider: APIService())
    private let cellIdentifier = "CategoriesTableViewCell"
    private let seagueIdentifer = "subCategory"
    private let pageTitle = "Select your Favorite Food!"
    var categoryName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = pageTitle
        self.viewModel.onErrorHandling = { error in
            self.displayError()
        }
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadTableView()
    }
    
    private func reloadTableView() {
        self.viewModel.setcategoriesDataDidChangeClosure {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func displayError() {
        // TODO: diplay error
    }
}


// MARK: Tableview delegate, datasource
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoriesTableViewCell else { return UITableViewCell() }
        let dataModel = viewModel.categoriesData[indexPath.row]
        cell.configureCell(dataModel: dataModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categoriesData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataModel = viewModel.categoriesData[indexPath.row]
        if let strCategory = dataModel.strCategory {
            categoryName = strCategory
            self.performSegue(withIdentifier: seagueIdentifer, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == seagueIdentifer {
            if let viewController = segue.destination as? SubCategoriesViewController {
                 viewController.subCategoryName = categoryName
            }
        }
    }
    
}

