//
//  ESSharedDataManager.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 26.11.2020.
//

import Foundation

class ESDataManager {
    
    static let shared = ESDataManager()
    
    var models = [ESServerModel.Combined]()
    
    func set(coins: [ESServerModel.Coin], stakes: [ESServerModel.Stake]?, userCoins: [ESUserCoin]) {
        
        models.removeAll()
        
        let stakesMap = stakes?.asMap() ?? [String: ESServerModel.Stake]()
        let userCoinsMap = userCoins.asMap()
        
        for coin in coins {
            let model = ESServerModel.Combined(coin: coin,
                                               stake: stakesMap[coin.id ?? ""],
                                               userBalance: userCoinsMap[coin.id ?? ""]?.balance)
            models.append(model)
        }
    }
    
    func getModelWith(id: String) -> ESServerModel.Combined? {
        return models.filter({ $0.coin.id == id }).first
    }
    
}

private extension Array where Element == ESServerModel.Stake {
    func asMap() -> [String: ESServerModel.Stake] {
        return self.reduce(into: [:]) { result, model in
            result[model.coinId ?? ""] = model
        }
    }
}

private extension Array where Element == ESUserCoin {
    func asMap() -> [String: ESUserCoin] {
        return self.reduce(into: [:]) { result, model in
            result[model.symbol ?? ""] = model
        }
    }
}
