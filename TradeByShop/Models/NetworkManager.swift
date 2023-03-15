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
    
    //    func getLinks(deviceId: String, completion: @escaping (Result<Links, Error>) -> ()) {
    //        guard let url = URL(string: "http://176.99.11.213:8090/mobile/get_links?device_id=\(deviceId)") else { return }
    //        let param = [""]
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else { return }
    //        urlRequest.httpBody = httpBody
    //        let session = URLSession.shared
    //
    //        session.dataTask(with: urlRequest) { data, resp, err in
    //            guard let resp = resp else { return }
    //            guard let data = data else { return }
    //            do {
    //                let json = try JSONDecoder().decode(Links.self, from: data)
    //                completion(.success(json))
    //                print(json)
    //            } catch {
    //                completion(.failure(error))
    //                print(error)
    //            }
    //        } .resume()
    //    }
    //
    //
    //    func regNewUser(deviceId: String, completion: @escaping (Result<ServersList, Error>) -> ()) {
    //
    //        let date = NSDate()
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "dd-MM-yyyy"
    //        let dateRegistration = formatter.string(from: date as Date)
    //
    //        guard let url = URL(string: "http://176.99.11.213:8090/mobile/reg_new_user?date_registration=\(dateRegistration)&device_id=\(deviceId)&os=iOS") else { return }
    //        let param = [""]
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else { return }
    //        urlRequest.httpBody = httpBody
    //        let session = URLSession.shared
    //
    //        session.dataTask(with: urlRequest) { data, resp, err in
    //            guard let resp = resp else { return }
    //            print(resp)
    //
    //            guard let data = data else { return }
    //            do {
    //                let json = try JSONDecoder().decode(ServersList.self, from: data)
    //                completion(.success(json))
    //                print(json)
    //            } catch {
    //                completion(.failure(error))
    //                print(error)
    //            }
    //        } .resume()
    //    }
    //
    //    func getTrafficLimit(deviceId: String, completion: @escaping (Result<TrafficLimit, Error>) -> ()) {
    //
    //        guard let url = URL(string: "http://176.99.11.213:8090/mobile/get_traffic_limit?device_id=\(deviceId)") else { return }
    //        let param = [""]
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else { return }
    //        urlRequest.httpBody = httpBody
    //        let session = URLSession.shared
    //
    //        session.dataTask(with: urlRequest) { data, resp, err in
    //            guard let resp = resp else { return }
    //            print(resp)
    //
    //            guard let data = data else { return }
    //            do {
    //                let json = try JSONDecoder().decode(TrafficLimit.self, from: data)
    //                completion(.success(json))
    //                print(" traffic limit \(json)")
    //            } catch {
    //                completion(.failure(error))
    //                print("traffic limit error \(error)")
    //            }
    //        } .resume()
    //    }
    //
    //    func chekTraffic(deviceId: String, serverID: String, completion: @escaping (Result<TrafficLimit, Error>) -> ()) {
    //
    //        guard let url = URL(string: "http://176.99.11.213:8090/mobile/check_traffic?device_id=\(deviceId)&server_id=\(serverID)") else { return }
    //        let param = [""]
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else { return }
    //        urlRequest.httpBody = httpBody
    //        let session = URLSession.shared
    //
    //        session.dataTask(with: urlRequest) { data, resp, err in
    //            guard let resp = resp else { return }
    //            print(resp)
    //
    //            guard let data = data else { return }
    //            do {
    //                let json = try JSONDecoder().decode(TrafficLimit.self, from: data)
    //                completion(.success(json))
    //                print(" traffic limit \(json)")
    //            } catch {
    //                completion(.failure(error))
    //                print("traffic limit error \(error)")
    //            }
    //        } .resume()
    //    }
    //
    //    func getCost(completion: @escaping (Result<String, Error>) -> ()) {
    //        guard let url = URL(string: "http://176.99.11.213:8090/mobile/get_cost") else { return }
    //        let param = [""]
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else { return }
    //        urlRequest.httpBody = httpBody
    //        let session = URLSession.shared
    //
    //        session.dataTask(with: urlRequest) { data, resp, err in
    //            guard let resp = resp else { return }
    //            guard let data = data else { return }
    //            do {
    //                guard let cost = String(data: data, encoding: .ascii) else { return }
    //                completion(.success(cost))
    //                print("cost \(cost)")
    //            } catch {
    //                completion(.failure(error))
    //                print(error)
    //            }
    //        } .resume()
    //    }
    //
    //    func getVPNConfig(deviceId: String, server_id: String, completion: @escaping (Result<VPNConfig, Error>) -> ()) {
    //
    //        guard let url = URL(string: "http://176.99.11.213:8090/mobile/get_vpn_config?device_id=\(deviceId)&server_id=\(server_id)") else { return }
    //        let param = [""]
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else { return }
    //        urlRequest.httpBody = httpBody
    //        let session = URLSession.shared
    //
    //        session.dataTask(with: urlRequest) { data, resp, err in
    //            guard let resp = resp else { return }
    //            print(resp)
    //
    //            guard let data = data else { return }
    //            do {
    //                let json = try JSONDecoder().decode(VPNConfig.self, from: data)
    //                completion(.success(json))
    //                print(" traffic limit \(json)")
    //            } catch {
    //                completion(.failure(error))
    //                print("traffic limit error \(error)")
    //            }
    //        } .resume()
    //    }
    //
    //    func disconnect(deviceId: String, server_id: String, completion: @escaping (Result<TrafficLimit, Error>) -> ()) {
    //
    //        print("jтправляем на сервер дисконнект")
    //        guard let url = URL(string: "http://176.99.11.213:8090/mobile/disconnect?device_id=\(deviceId)&server_id=\(server_id)") else { return }
    //        let param = [""]
    //        var urlRequest = URLRequest(url: url)
    //        urlRequest.httpMethod = "POST"
    //        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else { return }
    //        urlRequest.httpBody = httpBody
    //        let session = URLSession.shared
    //
    //        session.dataTask(with: urlRequest) { data, resp, err in
    //            guard let resp = resp else { return }
    //            print(resp)
    //
    //            guard let data = data else { return }
    //            do {
    //                let json = try JSONDecoder().decode(TrafficLimit.self, from: data)
    //                completion(.success(json))
    //                print(" traffic limit \(json)")
    //            } catch {
    //                completion(.failure(error))
    //                print("traffic limit error \(error)")
    //            }
    //        } .resume()
    //    }
    
}
