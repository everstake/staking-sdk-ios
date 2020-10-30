//
//  EverstakeListModels.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

enum ESEverstakeList {
    
//MARK: UI Models
    
    struct ViewModel {
        var readyToStakeList = [Coin]()
        var steakedList = [Coin]()
    }
    
    struct Coin {
        
        let id: String!
        let title: String
        let iconUrl: URL?
        let apr: Int?
        let comingSoon: Bool
        let amount: Double?
        let symbol: String?
        let order: Int
        
        var displayApr: String {
           return "\(apr ?? 0)%"
        }
        
        var displayAmount: String {
            if let amount = amount,
               let symbol = symbol,
               amount > 0 {
                return "\(amount) " + symbol
            } else {
                return ""
            }
        }
        
        init(coin: ESSharedModel.Coin, stake: ESSharedModel.Stake?) {
            id = coin.id
            title = coin.name ?? ""
            iconUrl = coin.iconUrl
            apr = coin.apr
            comingSoon = coin.isActive ?? true
            symbol = coin.symbol
            order = coin.order ?? 0
            amount = stake?.amount
        }
        
    }
    
//MARK: Action

    enum Action  {
        case openCoinDetail
    }

}
