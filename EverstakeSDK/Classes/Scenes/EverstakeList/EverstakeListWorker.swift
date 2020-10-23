//
//  EverstakeListWorker.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

class EverstakeListWorker {
    
    struct Constants {
        static let coinList = "coin"
        static let stake = "stake"
    }
    
    func loadCoinList(successWith: @escaping (Data) -> Void) {
        ESNetworkManager.loadDataWith(path: Constants.coinList, httpMethod: .get) { (data) in
            successWith(data)
        }
    }
    
    func loadStakeList(successWith: @escaping (Data) -> Void) {
        ESNetworkManager.loadDataWith(path: Constants.stake, httpMethod: .put) { (data) in
            successWith(data)
        }
    }
    
}
