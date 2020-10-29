//
//  EverstakeListPresenter.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol ESEverstakeListPresentationLogic {
    func updateWith(coins: [String: ESEverstakeList.Response.Coin],
                    stakes: [String: ESEverstakeList.Response.Stake])
}

class ESEverstakeListPresenter: ESEverstakeListPresentationLogic {
    
    weak var viewController: ESEverstakeListDisplayLogic?
    
    func updateWith(coins: [String: ESEverstakeList.Response.Coin],
                    stakes: [String: ESEverstakeList.Response.Stake]) {
                  
        var viewModel = convertToViewModel(coins: coins, stakes: stakes)
        
        viewModel.readyToStakeList.sort(by: sortLogic)
        viewModel.steakedList.sort(by: sortLogic)
        
        viewController?.updateWith(viewModel: viewModel)
    }
    
    private func sortLogic(this: ESEverstakeList.CoinModel,
                        that: ESEverstakeList.CoinModel) -> Bool {
        if (this.order == that.order) {
            return this.title > that.title
        } else {
            return this.order > that.order
        }
    }
    
//MARK: Private
    
    private func convertToViewModel(coins: [String: ESEverstakeList.Response.Coin],
                                    stakes: [String: ESEverstakeList.Response.Stake]) -> ESEverstakeList.ViewModel {
        
        var result = ([ESEverstakeList.CoinModel](),
                      [ESEverstakeList.CoinModel]())
                
        for key in coins.keys {
            guard let coin = coins[key] else {
                break
            }
            
            let stake = stakes[key]
            let model = ESEverstakeList.CoinModel(coin: coin, stake: stake)
            
            if let s = stake, s.amount > 0 {
                result.0.append(model)
            } else {
                result.1.append(model)
            }
        }
        
        return ESEverstakeList.ViewModel(readyToStakeList: result.1,
                                            steakedList: result.0)
    }
    
}
