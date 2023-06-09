//
//  Page1VC.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import UIKit

class Page1VC: UIViewController {
    
    private var searchList: SearchList?
    var searchWords = [String]()
    var dictionaryCategory = [String: Product]()
    private var tapGesture = UITapGestureRecognizer()

    private let productsList = ["phones",
                                "headphones",
                                "games",
                                "cars",
                                "furniture",
                                "kids"]
    
    private let categoryList = ["Latest",
                                "Flash Sale",
                                "Brands"]
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchPlaceholderLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    private var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupKeyBoard()
        fetchData()

    }
    
    private func setup() {
        
        navigationController?.navigationBar.isHidden = true
        
        /// setup search tableview
        searchTableView = UITableView(frame: CGRect(x: 50, y: 190, width: searchTextField.bounds.width, height: 200))
        let cellNibs = UINib(nibName: "SearchValueTableViewCell", bundle: nil)
        searchTableView.register(cellNibs, forCellReuseIdentifier: "SearchValueTableViewCell")
        
        searchTableView.isHidden = true
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.textAlignment = .center
        self.view.addSubview(searchTableView)
        
        /// setup main tableview
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        let cellNib = UINib(nibName: "WallpaperTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "WallpaperTableView")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupKeyBoard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGetstureDetected))
        tapGesture.numberOfTapsRequired = 1
    }
    
    @objc func tapGetstureDetected(){
        view.endEditing(true)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        print("keyboardWillAppear")
        view.addGestureRecognizer(tapGesture)
    }

    @objc func keyboardWillDisappear() {
        print("keyboardWillDisappear")
        view.removeGestureRecognizer(tapGesture)
    }
    
    private func fetchData() {
        
        var isSuccesLoadData = false
        
        Service.shared.getFlashSale { (res) in
            switch res {
            case .failure(let err):
                print("Errrrrr", err)
                
            case .success(let category):
                let flashSale = ProductCategory.flashSale.rawValue
                self.dictionaryCategory[flashSale] = category
                isSuccesLoadData = true
            }
        }
        
        Service.shared.getLatestProducts { (res) in
            switch res {
            case .failure(let err):
                print("Errrrrr", err)
                
            case .success(let category):
                if isSuccesLoadData {
                    
                    let latest = ProductCategory.latest.rawValue
                    self.dictionaryCategory[latest] = category
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func editingDidEndSearch(_ sender: UITextField) {
        if searchPlaceholderLabel.text == "" {
            searchPlaceholderLabel.isHidden = false
        }
    }
    
    @IBAction func editingDidBeginSearch(_ sender: UITextField) {
        searchPlaceholderLabel.isHidden = true
    }
    
    @IBAction func editingChangedSearch(_ sender: UITextField) {
        guard let searchText = sender.text else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            if let searchList = self.searchList {
                
                self.searchWords = (searchList.words?.filter{$0.lowercased().contains(searchText.lowercased())})!
                
                if !self.searchWords.isEmpty {
                    
                    self.searchTableView.isHidden = false
                    self.searchTableView.reloadData()
                    
                } else {
                    
                    self.searchTableView.isHidden = true

                }
                
            } else {
                
                Service.shared.getSearchList { (res) in
                    switch res {
                    case .failure(let err):
                        print("Errrrrr", err)
                        
                    case .success(let searchList):
                        self.searchList = searchList
                        
                    }
                }
            }
        }
    }
    
}

extension Page1VC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView == searchTableView ? 1 : ProductCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView == searchTableView ? searchWords.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchTableView {
            return 50
        }
        
        if indexPath.section == 1 {
            return 300
        } else {
            return 150
        }
    }
    
    // Category Title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == self.searchTableView {
            return nil
        }
        
        let headerView = UIView()
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 15))
        headerView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "MontserratRoman-Bold", size: 20)
        titleLabel.text = categoryList[section]
        
        let seeAllButton = UIButton(frame: CGRect(x: view.bounds.width - 100, y: 0, width: 100, height: 10))
        headerView.addSubview(seeAllButton)
        seeAllButton.tag = section
        seeAllButton.titleLabel?.font = UIFont(name: "MontserratRoman-Bold", size: 12)
        seeAllButton.setTitle("View all", for: .normal)
        seeAllButton.setTitleColor(UIColor(hexString: "808080"), for: .normal)
        
        let action = UIAction { _ in
            print("tap \(seeAllButton.tag)")
            
            self.performSegue(withIdentifier: "goToPage2", sender: self)
        }
        seeAllButton.addAction(action, for: .primaryActionTriggered)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView == searchTableView ? 0 : 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchValueTableViewCell", for: indexPath) as! SearchValueTableViewCell
            
            if !searchWords.isEmpty {
                cell.searchTextLabel.text = searchWords[indexPath.row]
            }
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WallpaperTableView", for: indexPath) as? ProductTableViewCell
        
        switch indexPath.section {
            
        case 0:

            if let row = dictionaryCategory[ProductCategory.latest.rawValue]  {
                cell?.updateCellWith(row: row)
            }
            
        case 1:

            if let row = dictionaryCategory[ProductCategory.flashSale.rawValue]  {
                cell?.updateCellWith(row: row)
            }
            
        case 2:
            print(ProductCategory.flashSale.rawValue)
            if let row = dictionaryCategory[ProductCategory.latest.rawValue]  {
                cell?.updateCellWith(row: row)
            }
            
        default: break
        }
        
        // Set cell's delegate
        cell?.cellDelegate = self
        cell?.selectionStyle = .none
        
        return cell!
        
    }
}

extension Page1VC: ProductCollectionViewCellDelegate {
    func collectionView(collectionviewcell: ProductCollectionViewCell?, index: Int, didTappedInTableViewCell: ProductTableViewCell) {
        print("tap")
        performSegue(withIdentifier: "goToPage2", sender: nil)
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

extension Page1VC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}



