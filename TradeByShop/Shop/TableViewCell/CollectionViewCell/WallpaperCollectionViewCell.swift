//
//  WallpaperCollectionViewCell.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

class WallpaperCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
}
