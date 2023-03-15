//
//  WallpaperCollectionViewCell.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

class WallpaperCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageCategory: UIImageView!
    
    @IBOutlet weak var likeImage: UIImageView!
    
    @IBOutlet weak var addImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
}
