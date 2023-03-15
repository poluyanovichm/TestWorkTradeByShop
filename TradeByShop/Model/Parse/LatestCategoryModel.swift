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

