//
//  ESSharedDataManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 26.11.2020.
//

import Foundation

class ESDataManager {
    
    static let shared = ESDataManager()
    
    var models = [ESSharedModel.Combined]()
    
    func set(coins: [ESSharedModel.Coin], stakes: [ESSharedModel.Stake]?) {
        
        models.removeAll()
        
        let stakesMap = stakes?.asMap() ?? [String: ESSharedModel.Stake]()
        
        for coin in coins {
            let model = ESSharedModel.Combined(coin: coin,
                                               stake: stakesMap[coin.id ?? ""])
            models.append(model)
        }
    }
    
}

private extension Array where Element == ESSharedModel.Stake {
    func asMap() -> [String: ESSharedModel.Stake] {
        return self.reduce(into: [:]) { result, model in
            result[model.coinId!] = model
        }
    }
}
