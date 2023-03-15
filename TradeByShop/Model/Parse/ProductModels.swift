//
//  WallpaperModels.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import Foundation

protocol Product {
    var flashSale: [FlashSaleElement]? { get }
}

// MARK: - FlashSale
struct FlashSale: Codable, Product {
    
    let flashSale: [FlashSaleElement]?

    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

// MARK: - FlashSaleElement
struct FlashSaleElement: Codable {
    let category, name: String?
    let price: Double?
    let discount: Int?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageURL = "image_url"
    }
}

enum ProductCategory: String, CaseIterable {
    case flashSale = "flash_sale"
    case latest = "latest"
    case brands = "brands"
}


