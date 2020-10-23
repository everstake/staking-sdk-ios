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
                  
        var readyToStake = [EverstakeList.CoinModel]()
        var staked = [EverstakeList.CoinModel]()
        
        //TODO: Refactor
        
        for key in coins.keys {
            guard let coin = coins[key],
                  let stake = stakes[key] else {
                break
            }
            
            let model = EverstakeList.CoinModel(coin: coin, stake: stake)
            
            if stake.floatAmount > 0 {
                staked.append(model)
            } else {
                readyToStake.append(model)
            }
                        
        }
        
        let viewModel = EverstakeList.ViewModel(readyToStakeList: readyToStake,
                                                steakedList: staked)

    
        viewController?.updateWith(viewModel: viewModel)
    }
    
}
