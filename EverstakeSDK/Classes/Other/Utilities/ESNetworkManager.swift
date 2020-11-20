//
//  ESNetworkManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 23.10.2020.
//

import Foundation

class ESNetworkManager {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    private struct Constants {
        static let baseURL = "https://wallet-sdk.everstake.one/"
    }
    
    static func loadDataWith(path: String, httpMethod: HTTPMethod, queryParameters: [[String: String]]? = nil, successWith: @escaping (Data) -> Void) {
        let url = URL(string: Constants.baseURL + path)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = queryParameters?.asJSONData
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "application/json")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

                if error == nil, let data = data {
                    DispatchQueue.main.async {
                        successWith(data)
                    }
                    ESCache.shared.save(data, for: path)
                } else {
                    print(error ?? "ESNetworkManager: Unknown Error \n\(String(describing: response?.description))")
                }
                    
            })
        task.resume()
    
        ESCache.shared.getDataFor(path, successWith: successWith)
    }
}

extension Array {
    var asJSONData: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self)
        } catch {
            print("Failed to create JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
