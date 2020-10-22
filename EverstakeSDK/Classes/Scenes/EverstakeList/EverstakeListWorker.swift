//
//  EverstakeListWorker.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

class EverstakeListWorker {
    
    struct Constants {
        static let baseURL = "https://wallet-sdk-static.herokuapp.com/" //TODO: move to global constants
        static let coinList = "coin"
    }
    
    func loadStakingList(successWith: @escaping ([EverstakeList.Coin]) -> Void, failedWith: @escaping (Error) -> Void) {
        
        let session = URLSession.shared
        let url = URL(string: Constants.baseURL + Constants.coinList)!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in

                if error != nil {
                    DispatchQueue.main.async {
                        failedWith(error!)
                    }
                    return
                }
                
                do {
                    let coins = try JSONDecoder().decode([EverstakeList.Coin].self, from: data!)
                    DispatchQueue.main.async {
                        successWith(coins)
                    }
                } catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
                    
            })
        task.resume()
    
    }
    
}
