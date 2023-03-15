//
//  WallpaperTableViewCell.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

protocol WallpaperCollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: WallpaperCollectionViewCell?, index: Int, didTappedInTableViewCell: WallpaperTableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

class WallpaperTableViewCell: UITableViewCell {
    
    weak var cellDelegate: WallpaperCollectionViewCellDelegate?
    
    var dictionaryCategory = [String: Any]()
    
    var rowWithWallpapers: Product? //FlashSale?
//    var rowWithLatestCategory: LatestCategory?
    
    //  @IBOutlet var subCategoryLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        
        // TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
//        flowLayout.itemSize = CGSize(width: 150, height: 300)
        flowLayout.minimumLineSpacing = 16.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.backgroundColor = .clear
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        // Comment if you set Datasource and delegate in .xib
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // Register the xib for collection view cell
        let cellNib = UINib(nibName: "WallpaperCollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "Wallpapercollectionviewcellid")
        
        
        
    }
}

extension WallpaperTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWith(row: Product) {
                
        self.rowWithWallpapers = row
        
        self.collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? WallpaperCollectionViewCell
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.rowWithWallpapers?.flashSale?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Wallpapercollectionviewcellid", for: indexPath) as? WallpaperCollectionViewCell {
            
            if let file = self.rowWithWallpapers?.flashSale![indexPath.row].imageURL {
                
                Service.shared.getImage(urlStr: file) { (image) in
                    
                    switch image {
                    case .failure(let err):
                        print("Errrrrr", err)
                        
                    case .success(let img):
                    
                        DispatchQueue.main.async {
                            cell.image.image = img
                        }
                    }
                }
            }
            
            cell.image.contentMode = .redraw
            cell.layer.cornerRadius = 12
            cell.layer.masksToBounds = true
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.height / 1.5, height: collectionView.bounds.height)
    }
}
