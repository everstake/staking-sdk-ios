//
//  ESSharedDataManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 26.11.2020.
//

import Foundation

class ESDataManager {
    
    static let shared = ESDataManager()
    
    var models = [ESServerModel.Combined]()
    
    func set(coins: [ESServerModel.Coin], stakes: [ESServerModel.Stake]?) {
        
        models.removeAll()
        
        let stakesMap = stakes?.asMap() ?? [String: ESServerModel.Stake]()
        
        for coin in coins {
            let model = ESServerModel.Combined(coin: coin,
                                               stake: stakesMap[coin.id ?? ""])
            models.append(model)
        }
    }
    
}

private extension Array where Element == ESServerModel.Stake {
    func asMap() -> [String: ESServerModel.Stake] {
        return self.reduce(into: [:]) { result, model in
            result[model.coinId!] = model
        }
    }
}
