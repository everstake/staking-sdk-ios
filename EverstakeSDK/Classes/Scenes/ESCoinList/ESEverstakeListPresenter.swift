//
//  EverstakeListPresenter.swift
//
//  Created by Alex Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol ESEverstakeListPresentationLogic {
    func updateWith(coins: [String: ESServerModel.Coin],
                    stakes: [String: ESServerModel.Stake])
    func unableToLoadData()
}

class ESEverstakeListPresenter: ESEverstakeListPresentationLogic {
    
    weak var viewController: ESEverstakeListDisplayLogic?
    
    func updateWith(coins: [String: ESServerModel.Coin],
                    stakes: [String: ESServerModel.Stake]) {
                  
        var viewModel = convertToViewModel(coins: coins, stakes: stakes)
        
        viewModel.readyToStakeList.sort(by: sortLogic)
        viewModel.steakedList.sort(by: sortLogic)
        
        viewController?.updateWith(viewModel: viewModel)
    }
    
    func unableToLoadData() {
        viewController?.unableToLoadData()
    }
    
//MARK: Private
    
    private func sortLogic(this: ESEverstakeList.Coin,
                        that: ESEverstakeList.Coin) -> Bool {
        if (this.order == that.order) {
            return this.title > that.title
        } else {
            return this.order > that.order
        }
    }
    
    private func convertToViewModel(coins: [String: ESServerModel.Coin],
                                    stakes: [String: ESServerModel.Stake]) -> ESEverstakeList.ViewModel {
        
        var result = ([ESEverstakeList.Coin](),
                      [ESEverstakeList.Coin]())
                
        for key in coins.keys {
            guard let coin = coins[key] else {
                break
            }
            
            let stake = stakes[key]
            let model = ESEverstakeList.Coin(coin: coin, stake: stake)
            
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
