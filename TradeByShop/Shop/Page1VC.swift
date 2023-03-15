//
//  Page1VC.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

class Page1VC: UIViewController {
    
    private let productsList = ["phones",
                                "headphones",
                                "games",
                                "cars",
                                "furniture",
                                "kids"]
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var productsCollectionView: UICollectionView!
    
    private let categoryList = ["Latest",
                                "Flash Sale",
                                "Brands"]
    
    //    var saleCategory: FlashSale?
    //    var latestCategory: LatestCategory?
    
    var dictionaryCategory = [String: Product]()
    
    var tappedKey = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        // Register the xib for tableview cell
        let cellNib = UINib(nibName: "WallpaperTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "WallpaperTableView")
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()
    }
    
    private func fetchData() {
        
        var isSuccesLoadData = false
        
        Service.shared.getFlashSale { (res) in
            switch res {
            case .failure(let err):
                print("Errrrrr", err)
                
            case .success(let category):
                print(category)
                
                //                self.saleCategory = category
                
                let flashSale = ProductCategory.flashSale.rawValue
                self.dictionaryCategory[flashSale] = category
                isSuccesLoadData = true
                print("true 1")
            }
        }
        
        Service.shared.getLatestProducts { (res) in
            switch res {
            case .failure(let err):
                print("Errrrrr", err)
                
            case .success(let category):
                print(category)
                
                //                self.latestCategory = category
                
                if isSuccesLoadData {
                    
                    let latest = ProductCategory.latest.rawValue
                    self.dictionaryCategory[latest] = category
                    print("true 2")
                } else {
                    print("false 2")
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
        
        
    }
    
}

extension Page1VC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProductCategory.allCases.count //categoryList.count // wallpaperBoxArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    // Category Title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 44))
        headerView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        titleLabel.text = categoryList[section]
        
        //        let seeAllButton = UIButton(frame: CGRect(x: view.width - 100, y: 0, width: 100, height: 44))
        //        headerView.addSubview(seeAllButton)
        //        seeAllButton.tag = section
        //        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //        seeAllButton.setTitle("See all", for: .normal)
        //        seeAllButton.setTitleColor(.systemBlue, for: .normal)
        //
        //        let action = UIAction { _ in
        //            print("tap \(seeAllButton.tag)")
        //            self.tappedCategory = array[section].value
        //            self.tappedKey = array[section].key
        //            print("tappedCategory  \(self.tappedCategory)")
        //
        //            self.performSegue(withIdentifier: "WallpaperCategory", sender: self)
        //        }
        //        seeAllButton.addAction(action, for: .primaryActionTriggered)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WallpaperTableView", for: indexPath) as? WallpaperTableViewCell
        
        switch indexPath.section {
        case 0:
            print(ProductCategory.latest.rawValue)
            if let row = dictionaryCategory[ProductCategory.latest.rawValue]  {
                cell?.updateCellWith(row: row)
                
            }
            
        case 1:
            print(ProductCategory.flashSale.rawValue)
            if let row = dictionaryCategory[ProductCategory.flashSale.rawValue]  {
                cell?.updateCellWith(row: row)
                
            }
        default: break
        }
        
        // Set cell's delegate
        cell?.cellDelegate = self
        cell?.selectionStyle = .none
        
        return cell!
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //        if segue.identifier == "WallpaperCategory" {
        //            let DestViewController = segue.destination as! WallpaperCategoryVC
        //            DestViewController.tappedCategoryContact = tappedCategory
        //        }
        
    }
}

extension Page1VC: WallpaperCollectionViewCellDelegate {
    func collectionView(collectionviewcell: WallpaperCollectionViewCell?, index: Int, didTappedInTableViewCell: WallpaperTableViewCell) {
        
    }
}

extension Page1VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        
        cell.image.image = UIImage(named: productsList[indexPath.item])
        cell.nameLabel.text = productsList[indexPath.item]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
    
    
    
}


