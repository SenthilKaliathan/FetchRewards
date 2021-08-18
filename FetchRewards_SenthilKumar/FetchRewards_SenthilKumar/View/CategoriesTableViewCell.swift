//
//  CategoriesTableViewCell.swift
//  FetchRewards_SenthilKumar
//
//  Created by Senthil Kumar on 16/08/21.
//


import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImage: ImageCacheView!
    
    // View model - update tableview cell
    var dataModel: Categories! {
        didSet {
            updateUI()
        }
    } 
    
    // MARK: Init
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateUI() {
        categoryLabel.text = dataModel.strCategory
        categoryDescriptionLabel.text = dataModel.strCategoryDescription
        // Load image Async
        if let url =  dataModel.thumbImageUrl {
            thumbnailImage.loadImage(url: url)
        } else {
            thumbnailImage.image = UIImage(named: "food.png")
        }
    }
    
    func configureCell(dataModel: Categories) {
        self.dataModel = dataModel
    }
}
