//
//  LatestCategory.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import Foundation

// MARK: - LatestCategory
struct LatestCategory: Codable, Product {
    let flashSale: [FlashSaleElement]?
    
    enum CodingKeys: String, CodingKey {
        case flashSale = "latest"
    }
}



// MARK: - Latest
//struct Latest: Codable {
//    let category, name: String?
//    let price: Int?
//    let imageURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case category, name, price
//        case imageURL = "image_url"
//    }
//}
