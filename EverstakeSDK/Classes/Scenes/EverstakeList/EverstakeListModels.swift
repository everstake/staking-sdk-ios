//
//  EverstakeListModels.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

enum EverstakeList {
          
    struct ViewModel {
        let coins: [Coin]
    }
    
    struct Coin: Codable {
        let id: String?
        let symbol: String?
        let about: String?
    }
}
