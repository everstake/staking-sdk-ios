//
//  EverstakeListInteractor.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol EverstakeListBusinessLogic {
    func loadDataList()
}

protocol EverstakeListDataStore {
    var coins: [EverstakeList.Coin]? { get set }
    var stakes: [EverstakeList.Stake]? { get set }
}

class EverstakeListInteractor: EverstakeListBusinessLogic, EverstakeListDataStore {
    
    var coins: [EverstakeList.Coin]?
    var stakes: [EverstakeList.Stake]?
    
    var presenter: EverstakeListPresentationLogic?
    var worker = EverstakeListWorker()
    
    func loadDataList() {
        worker.loadCoinList(successWith: { data in
            self.coins = ESUtilities.decode([EverstakeList.Coin].self, from: data)
            self.tryCompleteLoad()
        })
        
        worker.loadStakeList(successWith: { data in
            self.stakes = ESUtilities.decode([EverstakeList.Stake].self, from: data)
            self.tryCompleteLoad()
        })
    }
    
    private func tryCompleteLoad() {
        
        //TODO: show coins list, not wait for stakes

        guard let coins = coins, let stakes = stakes else {
            return
        }
        
        let coinsMap = coins.reduce(into: [:]) { result, model in
            result[model.id!] = model
        }
        
        let stakesMap = stakes.reduce(into: [:]) { result, model in
            result[model.coinId!] = model
        }
        
        presenter?.updateWith(coins: coinsMap, stakes: stakesMap)
        
        self.coins = nil
        self.stakes = nil
    }
    
}
