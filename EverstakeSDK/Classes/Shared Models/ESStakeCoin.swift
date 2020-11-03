//
//  ESSharedModels.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 29.10.2020.
//

import Foundation

//MARK: - Server Models

struct ESSharedModel {
    
    struct Combined {
        let coin: Coin
        let stake: Stake?
    }
            
    struct Stake: Codable {
        
        let _amount: String?
        let coinId: String?
        let amountToClaim: String?
        
        let validator: Validator?

        enum CodingKeys: String, CodingKey {
            case _amount = "amount"
            case coinId
            case amountToClaim
            case validator
        }

        struct Validator: Codable {
            let id: String?
            let name: String?
            let fee: String?
            let isReliable: Bool?
        }
        
        var amount: Double {
            return Double(_amount ?? "") ?? 0
        }
        
    }

    struct Coin: Codable {
        
        let id: String?
        let name: String?
        let iconUrl: URL?
        let apr: String?
        let isActive: Bool?
        let symbol: String?
        let order: String?
        let about: String?

        let fee: Fee?


    //        let precision: Int?
    //        let yieldInterval: Int?
    //        let yieldPercent: String?
    //        let needsClaiming: Bool?
    //        let intervalStake: Int?
    //        let intervalUnstake: Int?
    //        let toUsd: String?
    //        let aboutUrl: URL?
        
        struct Fee: Codable {
            let min: String?
            let max: String?
        }
    
    }
        
}

