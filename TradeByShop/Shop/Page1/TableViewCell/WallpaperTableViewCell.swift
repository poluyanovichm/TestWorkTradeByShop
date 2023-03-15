//
//  WallpaperTableViewCell.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

protocol WallpaperCollectionViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: WallpaperCollectionViewCell?, index: Int, didTappedInTableViewCell: WallpaperTableViewCell)
    
}

class WallpaperTableViewCell: UITableViewCell {
    
    weak var cellDelegate: WallpaperCollectionViewCellDelegate?
    
    var dictionaryCategory = [String: Any]()
    
    var rowWithWallpapers: Product?

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
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
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
            
            cell.image.contentMode = .scaleAspectFill
            cell.layer.cornerRadius = 12
            cell.layer.masksToBounds = true
            cell.categoryView.layer.cornerRadius = 8
            cell.categoryView.layer.masksToBounds = true
            
            guard let product = rowWithWallpapers?.flashSale?[indexPath.item] else { return cell}
            
            if product.discount == nil {
                
                cell.peopleImage.isHidden = true
                cell.saleImage.isHidden = true
                cell.likeImage.isHidden = true
                cell.addImage.image = UIImage(named: "plusBig")
                
                cell.nameLabel.font = UIFont(name: "MontserratRoman-Bold", size: 12)
                cell.priceLabel.font = UIFont(name: "MontserratRoman-Bold", size: 8)
                cell.categoryLabel.font = UIFont(name: "MontserratRoman-Bold", size: 6)

                
            } else {
                cell.nameLabel.font = UIFont(name: "MontserratRoman-Bold", size: 18)
                cell.priceLabel.font = UIFont(name: "MontserratRoman-Bold", size: 14)
                cell.categoryLabel.font = UIFont(name: "MontserratRoman-Bold", size: 12)

            }
            
            cell.nameLabel.text = product.name
            cell.priceLabel.text = "$ \(product.price ?? 0)"
            cell.categoryLabel.text = product.category
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let product = rowWithWallpapers?.flashSale?[indexPath.item] else {
            return CGSize(width: collectionView.bounds.height / 1.5, height: collectionView.bounds.height)}

        if product.discount == nil {

            return CGSize(width: collectionView.bounds.width / 3 - 20, height: collectionView.bounds.height)


        } else {
            return CGSize(width: collectionView.bounds.width / 2 - 15, height: collectionView.bounds.height)

        }
        
//        return CGSize(width: collectionView.bounds.width / 2 - 20, height: collectionView.bounds.height)

        
    }
    
    
}
