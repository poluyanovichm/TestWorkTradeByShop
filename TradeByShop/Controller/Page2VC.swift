//
//  Page2VC.swift
//  TradeByShop
//
//  Created by Mikhail on 15.03.2023.
//

import UIKit

class Page2VC: UIViewController {
    
    private var productDescription: ProductDescription?
    private var price = 0
    
    var indexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var mainImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var nameProductTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var allPriceLabel: UILabel!
    @IBOutlet weak var descriptionProductLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var downView: UIView!
    
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var addToCartView: UIView!
    @IBOutlet weak var blackView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
    }
    
    private func fetchData() {
        
        Service.shared.getProductDescriptions{ (res) in
            switch res {
            case .failure(let err):
                print("Errrrrr", err)
                
            case .success(let descriptions):
                self.productDescription = descriptions
                
                DispatchQueue.main.async {
                    self.imagesCollectionView.reloadData()
                    self.colorsCollectionView.reloadData()
                    self.mainImagesCollectionView.reloadData()
                    
                    self.nameProductTextView.text = descriptions.name
                    self.priceLabel.text = "$ \(descriptions.price ?? 0)"
                    self.price = descriptions.price ?? 0
                    self.allPriceLabel.text = "# \(descriptions.price ?? 0)"
                    self.descriptionProductLabel.text = descriptions.description
                    self.ratingLabel.text = String(descriptions.rating ?? 0)
                    self.reviewsLabel.text = "(\(String(descriptions.numberOfReviews ?? 0))) reviews"
                    
                }
                
            }
        }
    }
    
    private func setup() {
        
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        colorsCollectionView.dataSource = self
        colorsCollectionView.delegate = self
        
        mainImagesCollectionView.dataSource = self
        mainImagesCollectionView.delegate = self
        
        downView.layer.cornerRadius = 14
        downView.layer.masksToBounds = true
        upView.layer.cornerRadius = 14
        upView.layer.masksToBounds = true
        addToCartView.layer.cornerRadius = 14
        addToCartView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        blackView.layer.cornerRadius = 30
        blackView.layer.masksToBounds = true
    }
    
    
    @IBAction func tapDownButton(_ sender: UIButton) {
        
        if price - (productDescription?.price ?? 0) >= 0 {
            price -= productDescription?.price ?? 0
            allPriceLabel.text = "# \(String(price))"
        }
        
    }
    
    @IBAction func tapUPButton(_ sender: UIButton) {
        price += productDescription?.price ?? 0
        allPriceLabel.text = "# \(String(price))"
    }
    
    @IBAction func tapAddToCartButton(_ sender: UIButton) {
        
    }
    
    
}

extension Page2VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case mainImagesCollectionView, colorsCollectionView:
            return productDescription?.imageUrls?.count ?? 0
        case imagesCollectionView:
            return productDescription?.imageUrls?.count ?? 0
        default:
            break
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == imagesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
            
            guard let imagesURLList = productDescription?.imageUrls else { return cell }
            let urlStr = imagesURLList[indexPath.item]
            Service.shared.getImage(urlStr: urlStr) { image in
                switch image {
                case .failure(let err):
                    print("Errrrrr", err)
                    
                case .success(let image):
                    
                    DispatchQueue.main.async {
                        cell.image.image = image
                        if self.imageView.image == nil {
                            self.imageView.image = image
                        }
                        
                    }
                }
            }
            
            cell.layer.cornerRadius = 12
            cell.layer.masksToBounds = true
            
            return cell
            
        }
        
        if collectionView == colorsCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorsCollectionViewCell", for: indexPath)
            cell.backgroundColor = .black
            
            guard let colorList = productDescription?.colors else { return cell }
            
            var colorStr = colorList[indexPath.item]
            let colorHex = String(colorStr.dropFirst())
            let color = UIColor(hexString: String(colorHex))
            cell.backgroundColor = color
            cell.layer.cornerRadius = 8
            
            if indexPath.item == 0 {
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor.gray.cgColor
            }
            
            return cell
        }
        
        if collectionView == mainImagesCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
            
            guard let imagesURLList = productDescription?.imageUrls else { return cell }
            let urlStr = imagesURLList[indexPath.item]
            Service.shared.getImage(urlStr: urlStr) { image in
                switch image {
                case .failure(let err):
                    print("Errrrrr", err)
                    
                case .success(let image):
                    
                    DispatchQueue.main.async {
                        cell.image.image = image
                        if self.imageView.image == nil {
                            self.imageView.image = image
                        }
                        
                    }
                }
            }
            
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            
        case imagesCollectionView:
            
            switch collectionView.indexPathsForSelectedItems?.first {
            case .some(indexPath):
                return CGSize(width: collectionView.bounds.height * 1.2, height: collectionView.bounds.height / 1.4 )
                
            default:
                return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height / 2)
            }
            
        case colorsCollectionView: return CGSize(width: 40, height: collectionView.bounds.height / 1.2)
            
        case mainImagesCollectionView: return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            
        default: break
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    // center cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == mainImagesCollectionView {
            return .zero
            
        } else {
            
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth: CGFloat = flowLayout.itemSize.width
            let cellSpacing: CGFloat = flowLayout.minimumInteritemSpacing
            var cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
            var collectionWidth = collectionView.frame.size.width
            var totalWidth: CGFloat
            
            collectionWidth -= collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
            
            repeat {
                totalWidth = cellWidth * cellCount + cellSpacing * (cellCount - 1)
                cellCount -= 1
            } while totalWidth >= collectionWidth
            
            if (totalWidth > 0) {
                let edgeInset = (collectionWidth - totalWidth) / 2
                return UIEdgeInsets.init(top: flowLayout.sectionInset.top, left: edgeInset, bottom: flowLayout.sectionInset.bottom, right: edgeInset)
            } else {
                return flowLayout.sectionInset
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imagesCollectionView {
            print("tap")
            
            self.indexPath = indexPath
            let cell = collectionView.cellForItem(at: indexPath) as! ImagesCollectionViewCell
            imageView.image = cell.image.image
            collectionView.performBatchUpdates(nil, completion: nil)
            
            mainImagesCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: true)
            
        }
        
        if collectionView == colorsCollectionView {
            let cell = collectionView.cellForItem(at: indexPath)! //ColorsCollectionViewCell
            
            for item in 0...collectionView.numberOfItems(inSection: 0) - 1 {
                if item == indexPath.item {
                    cell.layer.borderWidth = 2
                    cell.layer.borderColor = UIColor.gray.cgColor
                } else {
                    let cell = collectionView.cellForItem(at: IndexPath(item: item, section: 0))! // as! ColorsCollectionViewCell
                    cell.layer.borderWidth = 0
                }
            }
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = mainImagesCollectionView.contentOffset
        visibleRect.size = mainImagesCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        collectionView(imagesCollectionView, didSelectItemAt: indexPath)
    }
}
