//
//  EverstakeListWorker.swift
//
//  Created by Alex Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

class ESEverstakeListWorker {
    
    struct Constants {
        static let coinList = "coin"
        static let stake = "stake"
    }
    
    func loadCoinList(successWith: @escaping (Data?) -> Void) {
        ESNetworkManager.loadDataWith(path: Constants.coinList, httpMethod: .get) { (data) in
            successWith(data)
        }
    }
    
    func loadStakeList(request: ESEverstakeList.StakeRequest, successWith: @escaping (Data?) -> Void) {
        ESNetworkManager.loadDataWith(path: Constants.stake, httpMethod: .put, queryParameters: request.asParameters) { (data) in
            successWith(data)
        }
    }
    
}
