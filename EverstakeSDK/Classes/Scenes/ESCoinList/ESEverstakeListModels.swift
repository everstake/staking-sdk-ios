//
//  EverstakeListModels.swift
//
//  Created by Alex Koziaruk on 20.10.2020.
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
        let apr: String?
        let comingSoon: Bool
        let amount: Double?
        let symbol: String?
        let order: Int
        
        var displayApr: String {
           return (apr ?? "0") + "%"
        }
        
        var displayAmount: String {
            if let amount = amount,
               let symbol = symbol?.uppercased(),
               amount > 0 {
                return "\(amount) " + symbol
            } else {
                return ""
            }
        }
        
        init(coin: ESServerModel.Coin, stake: ESServerModel.Stake?) {
            id = coin.id
            title = coin.name ?? ""
            iconUrl = coin.iconUrl
            apr = coin.apr
            comingSoon = !(coin.isActive ?? false)
            symbol = coin.symbol
            order = Int(coin.order ?? "0") ?? 0
            amount = stake?.amount.rounded(toPlaces: 5)
        }
        
    }

//MARK: - Server Models
    
    struct StakeRequest {
        
        let coins: [Coin]!
        
        var asParameters: [[String: String]] {
            return coins.reduce(into: []) { (result, coin) in
                result.append(["coinId": coin.coinId,
                               "address": coin.address])
            }
        }
        
        struct Coin {
            let coinId: String!
            let address: String!
        }
    }

}
