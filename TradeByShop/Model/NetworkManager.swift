//
//  NetworkManager.swift
//  TradeByShop
//
//  Created by Mikhail on 14.03.2023.
//

import Foundation
import UIKit

class Service: NSObject {
    
    static let shared = Service()
    
    // cccccc
    
    func getFlashSale(completion: @escaping (Result<FlashSale, Error>) -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac") else { return }
        var urlRequest = URLRequest(url: url)
        //        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, resp, err in
            //            guard let resp = resp else { return }
            //            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(FlashSale.self, from: data!)
                completion(.success(json))
                print(json)
            } catch {
                completion(.failure(error))
                print(error)
            }
        } .resume()
    }
    
    func getLatestProducts(completion: @escaping (Result<LatestCategory, Error>) -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7") else { return }
        var urlRequest = URLRequest(url: url)
        //        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, resp, err in
            //            guard let resp = resp else { return }
            //            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(LatestCategory.self, from: data!)
                completion(.success(json))
                print(json)
            } catch {
                completion(.failure(error))
                print(error)
            }
        } .resume()
    }
    
    func getProductDescriptions(completion: @escaping (Result<ProductDescription, Error>) -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239") else { return }
        var urlRequest = URLRequest(url: url)

        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, resp, err in
            //            guard let resp = resp else { return }
            //            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(ProductDescription.self, from: data!)
                completion(.success(json))
                print(json)
            } catch {
                completion(.failure(error))
                print(error)
            }
        } .resume()
    }
    
    func getImage(urlStr: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        guard let url = URL(string: urlStr) else { return }
        var urlRequest = URLRequest(url: url)
        //        urlRequest.httpMethod = "GET"
        //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, resp, err in
            if let err = err {
                completion(.failure(err))
                print(err)
            } else {
//                guard let resp = resp else { return }
                guard let data = data else { return }
                
                guard let image = UIImage(data: data) else { return }
                completion(.success(image))
                print("image load success")
            }
            
        } .resume()
    }
    
    func getSearchList(completion: @escaping (Result<SearchList, Error>) -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/4c9cd822-9479-4509-803d-63197e5a9e19") else { return }
        var urlRequest = URLRequest(url: url)

        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { data, resp, err in
            //            guard let resp = resp else { return }
            //            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(SearchList.self, from: data!)
                completion(.success(json))
                print(json)
            } catch {
                completion(.failure(error))
                print(error)
            }
        } .resume()
    }
    
}
