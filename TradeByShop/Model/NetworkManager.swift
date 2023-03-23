//
//  NetworkManager.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import Foundation
import UIKit

class Service: NSObject {
    
    private let getFlashSaleURL = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
    private let getLatestProductsURL = "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
    private let getProductDescriptionsURL = "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
    private let getSearchListURL = "https://run.mocky.io/v3/4c9cd822-9479-4509-803d-63197e5a9e19"
    
    static let shared = Service()
    private let session = URLSession.shared
    
    private func putURLRequest(urlStr: String) -> URLRequest?  {
        guard let url = URL(string: urlStr) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        return urlRequest
    }
        
    func getFlashSale(completion: @escaping (Result<FlashSale, Error>) -> ()) {
        guard let urlRequest = putURLRequest(urlStr: getFlashSaleURL) else { return }
        session.dataTask(with: urlRequest) { data, resp, err in
        
            do {
                let json = try JSONDecoder().decode(FlashSale.self, from: data!)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
    
    func getLatestProducts(completion: @escaping (Result<LatestCategory, Error>) -> ()) {
        guard let urlRequest = putURLRequest(urlStr: getLatestProductsURL) else { return }
        session.dataTask(with: urlRequest) { data, resp, err in

            do {
                let json = try JSONDecoder().decode(LatestCategory.self, from: data!)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
    
    func getProductDescriptions(completion: @escaping (Result<ProductDescription, Error>) -> ()) {
        guard let urlRequest = putURLRequest(urlStr: getProductDescriptionsURL) else { return }
        session.dataTask(with: urlRequest) { data, resp, err in
            
            do {
                let json = try JSONDecoder().decode(ProductDescription.self, from: data!)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
    
    func getImage(urlStr: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let urlRequest = putURLRequest(urlStr: urlStr) else { return }
        session.dataTask(with: urlRequest) { data, resp, err in
            if let err = err {
                completion(.failure(err))
            } else {

                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                completion(.success(image))
            }
            
        } .resume()
    }
    
    func getSearchList(completion: @escaping (Result<SearchList, Error>) -> ()) {
        guard let urlRequest = putURLRequest(urlStr: getSearchListURL) else { return }
        session.dataTask(with: urlRequest) { data, resp, err in
            
            do {
                let json = try JSONDecoder().decode(SearchList.self, from: data!)
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        } .resume()
    }
    
}
