//
//  EverstakeListPresenter.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol EverstakeListPresentationLogic {
    func updateWith(coins: [String: EverstakeList.Coin],
                    stakes: [String: EverstakeList.Stake])
}

class EverstakeListPresenter: EverstakeListPresentationLogic {
    
    weak var viewController: EverstakeListDisplayLogic?
    
    func updateWith(coins: [String: EverstakeList.Coin],
                    stakes: [String: EverstakeList.Stake]) {
                  
        var viewModel = convertToViewModel(coins: coins, stakes: stakes)
        
        viewModel.readyToStakeList.sort{ $0.order > $1.order }
        viewModel.steakedList.sort{ $0.order > $1.order }
        
        viewController?.updateWith(viewModel: viewModel)
    }
    
//MARK: Private
    
    private func convertToViewModel(coins: [String: EverstakeList.Coin],
                                    stakes: [String: EverstakeList.Stake]) -> EverstakeList.ViewModel {
        
        var result = ([EverstakeList.CoinModel](),
                      [EverstakeList.CoinModel]())
                
        for key in coins.keys {
            guard let coin = coins[key] else {
                break
            }
            
            let stake = stakes[key]
            let model = EverstakeList.CoinModel(coin: coin, stake: stake)
            
            if let s = stake, s.amount > 0 {
                result.0.append(model)
            } else {
                result.1.append(model)
            }
        }
        
        return EverstakeList.ViewModel(readyToStakeList: result.1,
                                            steakedList: result.0)
    }
    
}
