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
        let _amountToClaim: String?
        let coinId: String?
        let validators: [Validator]?

        enum CodingKeys: String, CodingKey {
            case _amount = "amount"
            case _amountToClaim = "amountToClaim"
            case coinId
            case validators
        }
        
        var amount: Double {
            return Double(_amount ?? "") ?? 0
        }
        
        var amountToClaim: Double {
            return Double(_amountToClaim ?? "") ?? 0
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
        let precision: String?
        let stakeType: StakeType?
        let fee: Fee?

        let yieldInterval: String?
        let yieldPercent: String?
        
        let validators: [Validator]?

        enum StakeType: String, Codable {
            case oneToOne = "1to1"
            case manyToOne = "Nto1"
            case oneToMany = "1toN"
            case other
            
            init(from decoder: Decoder) throws {
                let label = try decoder.singleValueContainer().decode(String.self)
                self = StakeType(rawValue: label) ?? .other
            }
        }
        
        struct Fee: Codable {
            let min: String?
            let max: String?
        }
        
//        struct Validator: Codable {
//            let id: String?
//            let name: String?
//            let fee: String?
//            let isReliable: Bool?
//        }
    
    }
    
    struct Validator: Codable {
        let id: String?
        let name: String?
        let fee: String?
        let isReliable: Bool?
        let amount: String?
    }
        
}

