//
//  ESNewStakeModels.swift
//  Pods
//
//  Created by Alex Koziaruk on 04.11.2020.
//  Copyright (c) 2020 Noisy Miner. All rights reserved.
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
        let balance: Double?
        let precision: Int!
        
        let coin: ESServerModel.Coin!

        var perYear: Double!
        var perMonth: Double!
        var perDay: Double!

        var validatorTitleLabel: String!
        
        var currentValidators: [ESServerModel.Validator]?
        var selectedValidators: [ESServerModel.Validator]!

        init(model: ESServerModel.Combined,
             selectedValidators: [ESServerModel.Validator],
             amount: Double?) {
            apr = (model.coin.apr ?? "0") + "%"
            symbol = model.coin.symbol?.uppercased() ?? ""
            balance = Double(model.userBalance ?? "0")
            precision = Int(model.coin.precision ?? "5")
            coin = model.coin
            perYear = 0
            perMonth = 0
            perDay = 0
            amountToStake = amount ?? 0
            validatorTitleLabel = (model.coin.stakeType == .oneToMany) ? "Select validators" : "Select validator"

            currentValidators = model.stake?.validators
            self.selectedValidators = selectedValidators
        }
        
        var stakeAllowed: Bool {
            guard coin.stakeType == .oneToOne,
                  let currentId = currentValidators?.first?.id,
                  let newId = selectedValidators.first?.id else {
                return true
            }
            return currentId == newId
        }
        
        var validators: String {
            return selectedValidators.map({ ($0.name ?? "")} ).joined(separator: ", ")
        }
        
        var isReliable: Bool {
            return selectedValidators.contains(where: { $0.isReliable ?? true })
        }

        var amountToStake: Double {
            didSet {
                let calculation = ESCalculatorHelper.getCalculations(model: coin, amount: amountToStake)
                perYear = calculation.perYear
                perMonth = calculation.perMonth
                perDay = calculation.perDay
            }
        }
        
        var displayBalance: String {
            return format(amount: balance)
        }
        
        var displayPerYearAmount: String {
            return format(amount: perYear)
        }
        
        var displayPerMonthAmount: String {
            return format(amount: perMonth)
        }
        
        var displayPerDayAmount: String {
            return format(amount: perDay)
        }
        
        private func format(amount: Double?) -> String {
            if let amount = amount,
               let symbol = symbol {
                return amount.clean + " " + symbol
            } else {
                return ""
            }
        }
    }

}

