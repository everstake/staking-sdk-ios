//
//  ESNewStakeModels.swift
//  Pods
//
//  Created by Alexander Koziaruk on 04.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ESNewStake {
  
    struct ViewModel {
        
        let apr: String!
        let symbol: String!
        let amount: Double!
        let precision: Int!

        init(model: ESSharedModel.Combined) {
            apr = (model.coin.apr ?? "0") + "%"
            symbol = model.coin.symbol ?? ""
            amount = model.stake?.amount ?? 0
            precision = Int(model.coin.precision ?? "5")
        }
        
        var displayStakedAmount: String {
            if let amount = amount,
               let symbol = symbol,
               amount > 0 {
                return "\(amount) " + symbol
            } else {
                return ""
            }
        }
    }

}

