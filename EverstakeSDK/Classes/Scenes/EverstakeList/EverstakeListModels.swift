//
//  EverstakeListModels.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

enum EverstakeList {
    
    struct Coin: Codable {
        
        let id: String?
        let name: String?
        let iconUrl: URL?
        let apr: Int?

//        let precision: Int?
//        let order: Int?
//        let yieldInterval: Int?
//        let yieldPercent: String?
//        let isActive: Bool?
//        let symbol: String?
//        let needsClaiming: Bool?
//        let intervalStake: Int?
//        let intervalUnstake: Int?
//        let toUsd: String?
//        let about: String?
//        let aboutUrl: URL?
//        let fee: Fee?
        
    }
    
    struct Fee: Codable {
        let min: Int?
        let max: Int?
    }

}
