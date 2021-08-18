//
//  SubCategoriesTableViewCell.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//

import Foundation


import UIKit

class SubCategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var thumbnailImage: ImageCacheView!
    
    // View model - update tableview cell
    var dataModel: MealModel! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: Init
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        categoryLabel.text = dataModel.strMeal
        // Load image Async
        if let url =  dataModel.thumbImageUrl {
            thumbnailImage.loadImage(url: url)
        } else {
            thumbnailImage.image = UIImage(named: "food.png")
        }
    }
    
    func configureCell(dataModel: MealModel) {
        self.dataModel = dataModel
    }
}
