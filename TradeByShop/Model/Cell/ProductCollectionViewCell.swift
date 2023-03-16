//
//  WallpaperCollectionViewCell.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageCategory: UIImageView!
    
    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var saleImage: UIImageView!
    @IBOutlet weak var peopleImage: UIImageView!
    @IBOutlet weak var addImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryView: UIView!
    
    
    @IBOutlet weak var widthNameLayout: NSLayoutConstraint!
    @IBOutlet weak var heigthNameLayout: NSLayoutConstraint!
    
    @IBOutlet weak var heigtAddLayout: UIImageView!
    @IBOutlet weak var widthAddLayout: UIImageView!
    
    @IBOutlet weak var categoryLayout: NSLayoutConstraint!
    
    
    @IBOutlet weak var categoryToNameLayout: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
