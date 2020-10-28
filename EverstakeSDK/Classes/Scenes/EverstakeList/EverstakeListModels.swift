//
//  EverstakeListModels.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

enum EverstakeList {
        
//MARK: - UI Models
    
    struct ViewModel {
        var readyToStakeList = [CoinModel]()
        var steakedList = [CoinModel]()
    }
    
    struct CoinModel {
        
        let title: String?
        let iconUrl: URL?
        let apr: Int?
        let comingSoon: Bool
        let amountToClaim: String?
        
        init(coin: Coin, stake: Stake?) {
            title = coin.name
            iconUrl = coin.iconUrl
            apr = coin.apr
            comingSoon = coin.isActive ?? true
            amountToClaim = stake?.amountToClaim
        }
    }
    
    
//MARK: - Server Models
    
    struct Stake: Codable {
        
        let _amount: String?
        let coinId: String?
        let amountToClaim: String?
        
//        let validator: Validator?
//
//        struct Validator: Codable {
//            let id: String?
//            let validatorName: String?
//            let fee: String?
//            let isReliable: Bool?
//        }
        
        enum CodingKeys: String, CodingKey {
            case _amount = "amount"
            case coinId
            case amountToClaim
        }
        
        var amount: Double {
            return Double(_amount ?? "") ?? 0
        }
        
    }
    
    struct Coin: Codable {
        
        let id: String?
        let name: String?
        let iconUrl: URL?
        let apr: Int?
        let isActive: Bool?

//        let precision: Int?
//        let order: Int?
//        let yieldInterval: Int?
//        let yieldPercent: String?
//        let symbol: String?
//        let needsClaiming: Bool?
//        let intervalStake: Int?
//        let intervalUnstake: Int?
//        let toUsd: String?
//        let about: String?
//        let aboutUrl: URL?
//        let fee: Fee?
        
//        struct Fee: Codable {
//            let min: Int?
//            let max: Int?
//        }
        
    }
    
}